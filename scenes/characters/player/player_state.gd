class_name PlayerState extends Node

enum State { WALK, FIGHT }

signal transition_requested(from: PlayerState, to: State)

@export var state: State = State.WALK

var player: Player

func enter() -> void:
	pass

func exit() -> void:
	pass

func on_input(_event: InputEvent) -> void:
	pass

func on_gui_input(_event: InputEvent) -> void:
	pass
 
func on_mouse_entered() -> void:
	pass

func on_mouse_exited() -> void:
	pass

func on_battle_started(_enemy):
	pass

func on_request_walk_to(_position, _ability):
	pass
	
func physics_update(_delta):
	pass
