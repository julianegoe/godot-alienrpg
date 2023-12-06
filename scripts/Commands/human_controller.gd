class_name HumanController
extends PlayerController

@export var speed = 100
var input_direction: Vector2

@onready var animation_player = $"../../AnimationPlayer"


func _physics_process(_delta):
	input_direction = Input.get_vector("left", "right", "up", "down")
	player.velocity = input_direction * speed
	player.move_and_slide()
	if input_direction == Vector2.DOWN:
		animation_player.play("walk_front")
	if Input.is_action_just_released("down"):
		animation_player.play("idle_front")
	if input_direction == Vector2.UP:
		animation_player.play("walk_back")
	if Input.is_action_just_released("up"):
		animation_player.play("idle_back")
	if input_direction == Vector2.RIGHT:
		animation_player.play("walk_right")
	if Input.is_action_just_released("right"):
		animation_player.play("idle_right")
	if input_direction == Vector2.LEFT:
		animation_player.play("walk_left")
	if Input.is_action_just_released("left"):
		animation_player.play("idle_left")
