class_name PlayerStateMachine extends Node

@export var initial_state: PlayerState 

var current_state: PlayerState
var states := {}

func init(player: Player) -> void:
	for child in get_children():
		if child is PlayerState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.player = player
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func on_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)

func on_input_event(viewport, event, shape_idx) -> void:
	if current_state:
		current_state.on_input_event(viewport, event, shape_idx)

func on_mouse_entered() -> void:
	if current_state:
		current_state.on_mouse_entered()

func on_mouse_exited() -> void:
	if current_state:
		current_state.on_mouse_exited()
		
func _on_transition_requested(from: PlayerState, to: PlayerState.State):
	if from != current_state:
		printerr("current scene not correctly exited")
		return
	var new_state: PlayerState = states[to]
	if not new_state:
		printerr("attempt changing to nonexistent state")
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)
