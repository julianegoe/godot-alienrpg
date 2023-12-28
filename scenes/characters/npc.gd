class_name Npc extends CharacterBody2D

signal player_entered(body: Player)
signal player_exited(body: Player)

@onready var interaction_icon: Node2D = $TalkToMe

enum DistanceState {
	IN_VICINITY,
	FAR_AWAY,
}

var interaction_state: DistanceState = DistanceState.FAR_AWAY
	
func _ready():
	$AnimationPlayer.play("idle")
	interaction_icon.hide()

func _on_vicinity_body_entered(body):
	if body is Player:
		interaction_state = DistanceState.IN_VICINITY
		interaction_icon.show()
		interaction_icon.play_animation()
		interaction_icon.z_index = 100
		player_entered.emit(body)

func _on_vicinity_body_exited(body):
	if body is Player:
		interaction_state = DistanceState.FAR_AWAY
		interaction_icon.hide()
		player_exited.emit(body)
