class_name EnemyState extends Node

enum State { PURSUIT, ATTACK, STARTLED, DEFEATED }

signal transition_requested(from: EnemyState, to: State)

@export var state: State = State.PURSUIT

var enemy: Node

func enter() -> void:
	pass

func exit() -> void:
	pass
	
func take_damage(_damage):
	pass
	
func on_attack_finished():
	pass
	
func on_vicinity_body_entered(_body):
	pass

func on_vicinity_body_exited(_body):
	pass
	
func on_startle_timer_timeout():
	pass

func on_defeated():
	pass
	
func physics_update(_delta):
	pass
