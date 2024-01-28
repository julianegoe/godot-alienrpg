class_name BattleArea extends Node2D
@export var player: Player
@onready var battle_dashboard = $UI/Dashboard
@onready var card_container = $UI/Dashboard/Hand/CardContainer
@onready var hand = $UI/Dashboard/Hand
@onready var actions_label = $UI/Actions
@onready var turn_label = $UI/Turn

var turn_manager = preload("res://resources/turn_manager.tres")
var effects_manager = preload("res://resources/effects_manager.tres")

func _ready():
	turn_manager.player_turn_started.connect(_on_player_turn_started)
	turn_manager.enemy_turn_started.connect(_on_enemy_turn_started)	
	turn_manager.action_changed.connect(_on_actions_changed)
	Events.battle_started.connect(_on_battle_started)
	hand.cards_updated.connect(_on_cards_updated)
	for card in card_container.get_children(false):
		if card.is_connected("activated", _on_card_played):
			pass
		else:
			card.activated.connect(_on_card_played)
			card.played.connect(_on_card_played)

func _on_cards_updated():
	for card in card_container.get_children(false):
		if card.is_connected("activated", _on_card_played):
			pass
		else:
			card.activated.connect(_on_card_played)
			card.played.connect(_on_card_played)

func _on_battle_started(enemy):
	actions_label.text = str(turn_manager.actions)
	turn_manager.enemies.clear()
	turn_manager.enemies.append(enemy)
	effects_manager.clear_effects(EffectsManager.ENEMY)
	effects_manager.clear_effects(EffectsManager.PLAYER)
	enemy.ui.show()
	if enemy.is_connected("defeated", _on_enemy_defeated):
		pass
	else:
		enemy.defeated.connect(_on_enemy_defeated)
		enemy.vanished.connect(_on_enemy_vanished)
	var tween = create_tween()
	tween.tween_property(player.camera, "zoom", Vector2(2, 2), 1)
	battle_dashboard.show_dashboard()
	battle_dashboard.disabled = false
	
func _on_player_turn_started():
	turn_label.text = "Player's turn"
	battle_dashboard.disabled = false

func _on_card_played(card: AbilityCard):
	if turn_manager.actions > 0:
		turn_manager.actions -= 1
		for effect in card.ability.effects:
			effects_manager.add_effect(effect, EffectsManager.PLAYER)
			effects_manager.apply_effetcs(EffectsManager.PLAYER, turn_manager.enemies[0])
			effects_manager.clear_effects(EffectsManager.PLAYER)
	else:
		return
		
func _on_actions_changed(actions: String):
	actions_label.text = actions
	if actions == "0":
		turn_manager.turn = turn_manager.calculate_next_turn(effects_manager.current_effects[EffectsManager.PLAYER])
	
func _on_enemy_turn_started():
	turn_label.text = "Enemy's turn"
	battle_dashboard.disabled = true
	if not is_instance_valid(player):
		return
	if turn_manager.enemies.is_empty():
		_finish_battle()
	else:
		for enemy in turn_manager.enemies:
			await enemy.attack(player)
			turn_manager.turn = turn_manager.calculate_next_turn(effects_manager.current_effects[EffectsManager.ENEMY])
		
func _on_enemy_defeated():
	_finish_battle()

func _on_enemy_vanished():
	_finish_battle()

func _on_end_turn_button_pressed():
	turn_manager.turn = turn_manager.calculate_next_turn(effects_manager.current_effects[EffectsManager.PLAYER])

func _finish_battle():
	turn_manager.enemies.clear()
	turn_manager.actions = 2
	var tween = create_tween()
	tween.tween_property(player.camera, "zoom", Vector2(1, 1), 1)
	battle_dashboard.hide_dashboard()
	battle_dashboard.disabled = true
	Events.battle_finished.emit()
	
