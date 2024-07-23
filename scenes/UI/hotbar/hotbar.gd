class_name HotBar extends Control

@export var inventory: InventoryResource
@export var slot_path: String
@export var slot_count: int
@export var disabled: bool = false:
	set(value):
		disabled = value
		if disabled:
			hide()
		else:
			show()

@onready var selector = $Selector
@onready var container = $MarginContainer/Container
@onready var slot_scene = preload("res://scenes/ui/hotbar/hotbar_slot.tscn")

const SELECTOR_DEFULT_POSITION = Vector2(240, 270)

func _ready():
	create_slots()
	update_slots()
	for slot in container.get_children():
		slot.pressed.connect(_on_slot_pressed.bind(slot))
	InventoryManager.item_added.connect(_on_item_added)
	InventoryManager.item_removed.connect(_on_item_removed)
	InventoryManager.item_equipped.connect(_on_item_equipped)
	InventoryManager.item_quick_selected.connect(_on_item_quick_selected)
	InventoryManager.item_stashed.connect(_on_item_stashed)
	InventoryManager.item_changed_hotbar_position.connect(_on_item_changed_position)


func _on_slot_pressed(slot: HotbarSlot):
	InventoryManager.equip_item(slot.item_resource)
	var new_position = slot.global_position - Vector2.ONE
	move_selector_to(new_position)
	
func _on_item_added(_item: ItemResource):
	update_slots()

func _on_item_removed(item: ItemResource):
	if item.hotbar_quantity == 0:
		move_selector_to(SELECTOR_DEFULT_POSITION)
	update_slots()

func _on_item_equipped(item: ItemResource):
	print("equipped ", item.display_name)

func _on_item_quick_selected(_item: ItemResource):
	update_slots()

func _on_item_stashed(item: ItemResource):
	if item.hotbar_quantity == 0:
		move_selector_to(SELECTOR_DEFULT_POSITION)
	update_slots()

func _shortcut_input(event):
	if event.is_action_pressed("hotkey") and not disabled:
		var key = OS.get_keycode_string(event.keycode)
		var slot = container.get_child(int(key) - 1)
		if slot.item_resource:
			move_selector_to(slot.global_position - Vector2.ONE)
			InventoryManager.equip_item(slot.item_resource)

func _on_item_changed_position(_item: ItemResource, _new_position: int):
	update_slots()	

func update_slots():
	for slot in container.get_children():
		slot.item_resource = null
		slot.item_icon.hide()
		slot.text = str(0)
		slot.disabled = true
	var data = inventory.filter_items_by_hotbar()
	for item in data:
		if item.hotbar_position >= 0 and item.hotbar_position < slot_count:
			var slot = container.get_child(item.hotbar_position)
			slot.item_resource = item
			slot.item_icon.region_rect = item.texture_region_rect
			slot.item_icon.show()
			slot.text = str(item.hotbar_quantity)
			if item.hotbar_quantity == 0:
				slot.disabled = true
			else:
				slot.disabled = false

			
func create_slots():
	for index in slot_count:
		var slot = slot_scene.instantiate()
		container.add_child(slot)
		
func move_selector_to(new_position: Vector2):
	selector.global_position = new_position
	
