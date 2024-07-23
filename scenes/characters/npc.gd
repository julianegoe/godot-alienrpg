class_name Npc extends CharacterBody2D

signal player_entered(body: Player)
signal player_exited(body: Player)

@onready var arrow_cursor = preload("res://assets/cursors/arrow_outlined.png")
@onready var target_cursor = preload("res://assets/cursors/cursor_target.png")
@onready var interaction_icon: Node2D = $Ui/icon

enum DistanceState {
	IN_VICINITY,
	FAR_AWAY,
}

var interaction_state: DistanceState = DistanceState.FAR_AWAY

func _on_vicinity_body_entered(body):
	if body is Player:
		interaction_state = DistanceState.IN_VICINITY
		interaction_icon.show()
		interaction_icon.play_animation()
		interaction_icon.z_index = 100
		player_entered.emit(body)
		Input.set_custom_mouse_cursor(arrow_cursor, Input.CURSOR_ARROW) 

func _on_vicinity_body_exited(body):
	if body is Player:
		interaction_state = DistanceState.FAR_AWAY
		interaction_icon.hide()
		player_exited.emit(body)
		Input.set_custom_mouse_cursor(target_cursor, Input.CURSOR_ARROW)
