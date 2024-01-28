class_name Hand extends MarginContainer

signal cards_updated()

var ability_card_scene: PackedScene = preload("res://scenes/battle/abilityCard/ability_card.tscn")
@export var inventory: MenuResource
@onready var card_container = $CardContainer

func _ready():
	inventory.equipped_cards_update.connect(_on_cards_equipped)
	_update_cards(inventory.equipped_abilities)

func _update_cards(equipped_cards: Array):
	for card in card_container.get_children(false):
		card.queue_free()
	for equipped in equipped_cards:
		var ability_card = ability_card_scene.instantiate()
		ability_card.ability = equipped
		card_container.add_child(ability_card)
	cards_updated.emit()

func _on_cards_equipped():
	_update_cards(inventory.equipped_abilities)
