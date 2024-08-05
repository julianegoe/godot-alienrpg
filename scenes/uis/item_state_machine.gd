class_name ItemStateMachine extends Node

@export var initial_state: ItemState

var current_state: ItemState
var states := {}

func init(item: TextureButton) -> void:
	for child in get_children():
		if child is ItemState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.item = item
	if initial_state:
		initial_state.enter()
		current_state = initial_state


func _on_transition_requested(from: ItemState, to: ItemState.State):
	if from != current_state:
		printerr("current scene not correctly exited")
		return
	var new_state: ItemState = states[to]
	if not new_state:
		printerr("attempt changing to nonexistent state")
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state

func input(event: InputEvent):
	if current_state:
		current_state.input(event)

func on_button_pressed():
	if current_state:
		current_state.on_button_pressed()
	
func on_button_up():
	if current_state:
		current_state.on_button_up()
	
func on_button_down():
	if current_state:
		current_state.on_button_down()

func on_mouse_entered(index: int):
	if current_state:
		current_state.on_mouse_entered(index)

func on_mouse_exited(index: int):
	if current_state:
		current_state.on_mouse_exited(index)

func on_dropable_mouse_entered(index: int):
	if current_state:
		current_state.on_dropable_mouse_entered(index)

func on_selector_area_entered(area):
	if current_state:
		current_state.on_selector_area_entered(area)

func on_selector_area_exited(area):
	if current_state:
		current_state.on_selector_area_exited(area)
	
func on_update(delta):
	if current_state:
		current_state.on_update(delta)
	
