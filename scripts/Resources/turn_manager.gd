class_name TurnManager extends Resource

signal player_turn_started
signal enemy_turn_started
signal action_changed(actions: String)

enum Turn { PLAYER_TURN, ENEMY_TURN }
var enemies = []
var MAX_ACTIONS = 2
var actions: int = MAX_ACTIONS:
	set(value):
		actions = clamp(value,-1,MAX_ACTIONS)
		action_changed.emit(str(actions))
	get:
		return actions

var turn: Turn:
	set(value):
		turn = value
		match turn:
			Turn.PLAYER_TURN: player_turn_started.emit()
			Turn.ENEMY_TURN: enemy_turn_started.emit()
	get:
		return turn

func calculate_next_turn(effects: Array[EffectResource]):
	var skip_turn = effects.filter(func(effect): return effect.type == effect.EffectType.SKIP_TURN)
	actions = MAX_ACTIONS
	if skip_turn.is_empty():
		return Turn.ENEMY_TURN if turn == Turn.PLAYER_TURN else Turn.PLAYER_TURN
	else:
		return turn
