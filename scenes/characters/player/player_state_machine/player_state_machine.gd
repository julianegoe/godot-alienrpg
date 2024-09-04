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

func on_item_equipped(item: ItemResource):
	if current_state:
		current_state.on_item_equipped(item)
	
func physics_update(delta):
	if current_state:
		current_state.physics_update(delta)
	
func on_attack_animation_finished():
	if current_state:
		current_state.on_attack_animation_finished()

func on_attack_ranged_start():
	if current_state:
		current_state.on_attack_ranged_start()
	
func on_charge_start():
	if current_state:
		current_state.on_charge_start()
	
func on_charge_indicator_animation_finished():
	if current_state:
		current_state.on_charge_indicator_animation_finished()
	
func on_health_exhausted():
	if current_state:
		current_state.on_health_exhausted()
	
