class_name PlayerState extends Node

enum State { WALK, ATTACK_RANGED, ATTACK_MELEE, EXHAUSTED, IDLE, CHARGE_MELEE, CHARGE_RANGED }

signal transition_requested(from: PlayerState, to: State)

@export var state: State = State.WALK

var player: Player

func enter() -> void:
	pass

func exit() -> void:
	pass

func on_input(_event: InputEvent) -> void:
	pass

func on_attack_animation_finished():
	pass

func on_attack_ranged_start():
	pass

func on_item_equipped(_item):
	pass
	
func physics_update(_delta):
	pass

func on_charge_start():
	pass

func on_charge_indicator_animation_finished():
	pass

func on_health_exhausted():
	pass
