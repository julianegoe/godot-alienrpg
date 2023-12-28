class_name Player extends CharacterBody2D

var currentVelocity : Vector2 = Vector2.ZERO
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(_delta):
	var inputDir : Vector2 = Vector2.ZERO
	#INPUTS
	inputDir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	inputDir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	inputDir = inputDir.normalized()
	currentVelocity = inputDir * 2
	move_and_collide(currentVelocity)
	if inputDir == Vector2.DOWN:
		animation_player.play("walk_front")
	if Input.is_action_just_released("down"):
		animation_player.play("idle_front")
	if inputDir == Vector2.UP:
		animation_player.play("walk_back")
	if Input.is_action_just_released("up"):
		animation_player.play("idle_back")
	if inputDir == Vector2.RIGHT:
		animation_player.play("walk_right")
	if Input.is_action_just_released("right"):
		animation_player.play("idle_right")
	if inputDir == Vector2.LEFT:
		animation_player.play("walk_left")
	if Input.is_action_just_released("left"):
		animation_player.play("idle_left")
