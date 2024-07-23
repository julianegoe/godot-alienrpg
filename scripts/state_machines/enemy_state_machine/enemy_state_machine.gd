class_name EnemyStateMachine extends Node

@export var initial_state: EnemyState

var current_state: EnemyState
var states := {}

func init(enemy: Enemy) -> void:
	for child in get_children():
		if child is EnemyState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.enemy = enemy
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _on_transition_requested(from: EnemyState, to: EnemyState.State):
	if from != current_state:
		printerr("current scene not correctly exited")
		return
	var new_state: EnemyState = states[to]
	if not new_state:
		printerr("attempt changing to nonexistent state")
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state
		
func take_damage(damage):
	if current_state:
		current_state.take_damage(damage)
	
func on_attack_finished():
	if current_state:
		current_state.on_attack_finished()
	
func on_vicinity_body_entered(body):
	if current_state:
		current_state.on_vicinity_body_entered(body)

func on_vicinity_body_exited(body):
	if current_state:
		current_state.on_vicinity_body_exited(body)
				
func on_startle_timer_timeout():
	if current_state:
		current_state.on_startle_timer_timeout()

func on_defeated():
	if current_state:
		current_state.on_defeated()
	
func physics_update(delta: int):
	if current_state:
		current_state.physics_update(delta)
