class_name ItemBar extends CanvasLayer

@export var resource: ItemBarResource
@onready var item_container = $Control/MarginContainer/ItemContainer
@onready var tilemap = $"../Tilemap"

var slots = []
# Called when the node enters the scene tree for the first time.
func _ready():
	slots = item_container.get_children(false)
	tilemap.pick_up_material.connect(_on_item_taken)
	for index in range(resource.items.size()):
		slots[index].set_disabled(false)
		slots[index].texture_normal = resource.items[index].texture
		slots[index].texture_pressed = resource.items[index].texture_hovered
		slots[index].set_meta("resource", resource.items[index])
	for slot in slots:
		slot.pressed.connect(_on_button_pressed.bind(slot))
		

func _on_item_taken(ability: AbilityResource):
	resource.items.append(ability)
	var empty_slot = _get_next_empty_slot()
	set_item_at(empty_slot, ability)

func set_item_at(slot: TextureButton, ability: AbilityResource):
	slot.set_disabled(false)
	slot.texture_normal = ability.texture
	slot.texture_pressed = ability.texture_hovered
	slot.set_meta("resource", ability)
	
func _get_next_empty_slot():
	var empty_slot
	for item in item_container.get_children(false):
		if item.disabled:
			empty_slot = item
			break
	return empty_slot


func _on_button_pressed(slot: TextureButton):
	var ability = slot.get_meta("resource")
	ability.is_selected = !ability.is_selected
	if ability.is_selected:
		slot.texture_normal = ability.texture_hovered
	else:
		slot.texture_normal = ability.texture
	Events.item_equipped.emit(ability)
