class_name PlayerAutoWalkState extends PlayerState

var speed = 0

func enter():
	speed = 200
	print("auto walk")

func exit():
	pass

func _on_battle_started(_enemy):
	transition_requested.emit(self, PlayerState.State.FIGHT)

func on_input(event: InputEvent):
	if event is InputEventMouseButton:
		transition_requested.emit(self, PlayerState.State.WALK)

func physics_update(_delta):
	player.velocity = player.position.direction_to(player.auto_walk_to) * speed
	if player.position.distance_to(player.auto_walk_to) > 10:
		player.move_and_slide()
