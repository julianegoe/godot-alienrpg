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
	for index in cards.size():
		cards[index].card_equipped.connect(_on_card_equipped)
		if index < menu_resource.unequipped_abilities.size() - 1:
			cards[index].card_resource.ability = menu_resource.unequipped_abilities[index]
			cards[index].card_resource.is_disabled = false
		else:
			cards[index].card_resource.is_disabled = true
		cards[index].init()
		
	for index in slots.size():
		slots[index].card_unequipped.connect(_on_card_unequipped)
		if index < menu_resource.equipped_abilities.size():
			slots[index].slot_resource.ability = menu_resource.equipped_abilities[index]
			slots[index].slot_resource.is_disabled = false
		else:
			slots[index].slot_resource.is_disabled = true
		slots[index].init()
			
func _on_item_taken(ability: AbilityResource):
	var empty_card = find_first_empty_card(card_container.get_children(false))
	empty_card.disabled = false
	empty_card.card_resource.ability = ability
	empty_card.card_texture = ability.texture
	empty_card.card_texture_hovered = ability.texture_hovered
	
func _on_card_equipped(ability: AbilityResource, card: CardButton):
	var empty_slot = find_first_empty_slot(slot_container.get_children(false))
	if empty_slot:
		var duplicate_ability = ability.duplicate(true)
		empty_slot.slot_resource.ability = duplicate_ability
		empty_slot.card_texture = duplicate_ability.texture
		empty_slot.disabled = false
		empty_slot.slot_resource.is_disabled = false
		card.disabled = true
		card.card_resource.is_disabled = true
		menu_resource.equipped_abilities = duplicate_ability

func _on_card_unequipped(ability: AbilityResource, slot: CardSlot):
	var empty_card = find_first_empty_card(card_container.get_children(false))
	if empty_card:
		empty_card.disabled = false
		empty_card.card_resource.is_disabled = false
		empty_card.card_resource.ability = ability
		empty_card.card_texture = ability.texture
		empty_card.card_texture_hovered = ability.texture_hovered
		slot.disabled = true
		menu_resource.equipped_abilities = ability
	
func find_first_empty_slot(slots):
	var empty_slots = slots.filter(func(slot): return slot.disabled)
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

