class_name PursuitPoC extends CharacterBody2D

@export var player: Player

const MAX_SPEED: int = 20
var speed: int = MAX_SPEED

@onready var startle_timer = $StartleTimer

func take_damage(damage: int):
	speed = 0
	if damage <= 100:
		startle_timer.wait_time = 2.5
	elif damage <= 102:
		startle_timer.wait_time = 3.0
	elif damage <= 105:
		startle_timer.wait_time = 3.5
	else:
		startle_timer.wait_time = 4
	startle_timer.start()
	
func _physics_process(_delta):
	if player:
		var direction = global_position.direction_to(player.global_position)
		move_and_slide()
		velocity = direction * speed

func _on_area_2d_body_entered(body: Player):
	if body is Player:
		speed = 0

func _on_area_2d_body_exited(body: Player):
	if body is Player:
		speed = MAX_SPEED

func _on_startle_timer_timeout():
	speed = MAX_SPEED
