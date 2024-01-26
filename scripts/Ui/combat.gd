class_name Combat extends Node2D

signal skill_check_effect(effects)

@export var player: Player
@export var menu: Menu
		
@onready var battle_area = $BattleArea
@onready var turn_queue = $TurnQueue

var battle_ui = preload("res://scenes/battle/battle_area.tscn")

func _ready():
	Events.battle_started.connect(_on_battle_started)

func perform_skill_check(attacker_skill, attacker_ability, opponent_defense):
	var attacker_modifier = attacker_skill + attacker_ability.modifier
	var oponent_modifier = opponent_defense
	var attacker_roll = _roll(attacker_modifier)
	var oponent_roll = _roll(oponent_modifier)
	if attacker_roll >= oponent_roll:
		skill_check_effect.emit(attacker_ability.effects)
	elif oponent_roll >= attacker_roll:
		return
	
func _roll(modifier: int):
	var rolled_number = randi_range(1, 20)
	return clamp(rolled_number + modifier, 0, 20)

func _on_battle_started(enemy):
	print(player.speechbubble.dialogue_resource.display_name, " vs. ", enemy.display_name)
	var tween = create_tween()
	tween.tween_property(player.camera, "zoom", Vector2(2, 2), 1)
	battle_area.add_cards(player.ability_cards.get_equipped_abilities())
	battle_area.show_hand()
	for card in battle_area.cards_container.get_children(false):
		card.activated.connect(_on_card_activated)
		card.played.connect(_on_card_played)

func _on_card_activated(card: AbilityCard):
	print(card, " activated")

func _on_card_played(card: AbilityCard):
	print(card, " played")
	menu._on_card_unequipped(card.ability)
	
