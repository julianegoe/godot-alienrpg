class_name BattleArea extends Node2D

@onready var cards_container: HBoxContainer = $UI/Hand/CardContainer
@onready var hand: MarginContainer = $UI/Hand

var ability_card_scene: PackedScene = preload("res://scenes/battle/abilityCard/ability_card.tscn")

func show_hand():
	var tween = create_tween()
	tween.tween_property(hand, "position:y", 200, 1)
	
func add_cards(equipped_cards: Array):
	for equipped in equipped_cards:
		var ability_card = ability_card_scene.instantiate()
		ability_card.card_resource = equipped
		cards_container.add_child(ability_card)
	
