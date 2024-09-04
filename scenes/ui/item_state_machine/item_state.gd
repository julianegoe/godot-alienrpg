class_name ItemState extends Node

enum State { IDLE, DRAGGING }

signal transition_requested(from: ItemState, to: State)

@export var state: State = State.IDLE

var item: TextureButton

func enter() -> void:
	pass

func exit() -> void:
	pass

func input(_event: InputEvent):
	pass

func on_button_pressed():
	pass

func on_button_down():
	pass

func on_button_up():
	pass

func on_mouse_entered(_index):
	pass

func on_mouse_exited(_index):
	pass

func on_dropable_mouse_entered(_index):
	pass

func on_selector_area_entered(_area):
	pass

func on_selector_area_exited(_area):
	pass
	
func on_update(_delta):
	pass
