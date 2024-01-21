class_name CardStateMachine extends Node

@export var initial_state: CardState 

var current_state: CardState
var states := {}

func init(ability_card: AbilityCard) -> void:
	for child in get_children():
		if child is CardState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.ability_card = ability_card
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func on_texture_button_pressed()->void:
	if current_state:
		current_state.on_texture_button_pressed()

func on_mouse_entered() -> void:
	if current_state:
		current_state.on_mouse_entered()

func on_mouse_exited() -> void:
	if current_state:
		current_state.on_mouse_exited()
			
func _on_transition_requested(from: CardState, to: CardState.State) -> void:
	if from != current_state:
		printerr(from, current_state)
		return
	var new_state: CardState = states[to]
	if not new_state:
		printerr("attempt changing to nonexistent state")
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state
