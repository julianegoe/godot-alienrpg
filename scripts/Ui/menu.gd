class_name Menu extends CanvasLayer

@export var menu_resource: MenuResource
@onready var card_container = $Control/Panel/ScrollContainer/CardContainer
@onready var slot_container = $Control/Panel/Left/SlotContainer
@onready var tilemap = $"../Tilemap"

var empty_card_scene = preload("res://scenes/UI/card_button.tscn")
var items: Array[Node]
var is_open: bool

func _ready():
	tilemap.pick_up_material.connect(_on_item_taken)
	items = get_tree().get_nodes_in_group("Items")
	for item in items:
		item.take_item.connect(_on_item_taken)
	var cards = card_container.get_children(false)
	var slots = slot_container.get_children(false)
	for card in cards:
		card.card_equipped.connect(_on_card_equipped)
		if card.card_resource:
			menu_resource.available_cards.append(card.card_resource)
	for slot in slots:
		if slot.slot_resource:
			menu_resource.available_slots.append(slot.slot_resource)
	
func _on_item_taken(ability: AbilityResource):
	var empty_card = find_first_empty_card(card_container.get_children(false))
	empty_card.disabled = false
	empty_card.card_resource.ability = ability
	empty_card.card_texture = ability.texture
	empty_card.card_texture_hovered = ability.texture_hovered
	
func _on_card_equipped(ability: AbilityResource, card: CardButton):
	var empty_slot = find_first_empty_slot(slot_container.get_children(false))
	if empty_slot:
		empty_slot.slot_resource.ability = ability
		empty_slot.card_texture = ability.texture
		empty_slot.is_equipped = true
		empty_slot.slot_resource.is_equipped = true
		card.disabled = true
		card.card_resource.is_disabled = true

func _on_card_unequipped(ability: AbilityResource):
	var slots = slot_container.get_children(false)
	var ability_slots = slots.filter(func(slot): return slot.slot_resource.ability == ability)
	print(slots.find(ability_slots[0]))
	slots.remove_at(slots.find(ability_slots[0]))
	
func find_first_empty_slot(slots):
	var empty_slots = slots.filter(func(slot): return !slot.is_equipped)
	if (not empty_slots.is_empty()):
		return empty_slots[0]
	else:
		return null
		
func find_first_empty_card(cards):
	var empty_cards = cards.filter(func(card): return card.disabled)
	if (not empty_cards.is_empty()):
		return empty_cards[0]
	else:
		var card_button = empty_card_scene.instantiate()
		card_button.card_resource = CardResource.new()
		card_button.card_equipped.connect(_on_card_equipped)
		card_container.add_child(card_button)
		return card_button
		
func _input(input: InputEvent):
	if input.is_action_pressed("inventory"):
		if is_open:
			hide()
			is_open = false
			get_tree().paused = false
		else:
			show()
			is_open = true
			get_tree().paused = true

