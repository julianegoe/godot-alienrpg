class_name PlayerWalkState extends PlayerState

var currentVelocity : Vector2 = Vector2.ZERO
var inputDir: Vector2
var SPEECHBUBBLE_OFFSET = Vector2(-58, -66)

func enter():
	print("WALK")

func exit():
	pass
	
func on_input(event):
	if event.is_action_pressed("skip") and player.speechbubble.is_activated:
		player.speechbubble.skip_text()
	if event.is_action_pressed("interact") and !!player.items.get_equipped():
		transition_requested.emit(self, PlayerState.State.FIGHT)
		
func on_battle_started(_enemy):
	transition_requested.emit(self, PlayerState.State.FIGHT)

func on_status_zero(_type: Types.Status):
	transition_requested.emit(self, PlayerState.State.EXHAUSTED)
	
func physics_update(_delta)-> void:
	inputDir = Vector2.ZERO
	#INPUTS
	inputDir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	inputDir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	inputDir = inputDir.normalized()
	currentVelocity = inputDir * 2
	player.move_and_collide(currentVelocity)
	if inputDir == Vector2.DOWN:
		player.animation_player.play("walk_front")
	if inputDir == Vector2.UP:
		player.animation_player.play("walk_back")
	if inputDir == Vector2.RIGHT:
		player.animation_player.play("walk_right")
	if inputDir == Vector2.LEFT:
		player.animation_player.play("walk_left")
	if Input.is_action_just_released("down"):
		player.animation_player.play("idle_front")
	if Input.is_action_just_released("up"):
		player.animation_player.play("idle_back")
	if Input.is_action_just_released("right"):
		player.animation_player.play("idle_right")
	if Input.is_action_just_released("left"):
		player.animation_player.play("idle_left")
	player.remote_transform_speechbuble.global_position = player.global_position + SPEECHBUBBLE_OFFSET
	
