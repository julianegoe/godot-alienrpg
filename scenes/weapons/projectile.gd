class_name Projectile extends Node2D

@export var projectile: AnimatableBody2D
@export var shadow = HitBox

var target_position: Vector2 = Vector2.ZERO
var time: float

const GRAVITY: int = 200
var direction: Vector2
var ground_velocity: Vector2 # moves the shadow linar on the ground
var vertical_velocity: float # moves the projectile in an arc
var actual_velocity: Vector2
var is_grounded: bool = true
var player_position: Vector2
var last_distance_to_ground: float

func init(new_ground_velocity: Vector2, new_vertial_velocity: float, ground: Vector2):
	z_index = 1
	shadow.visible = false
	direction = get_closest_cardinal_direction(new_ground_velocity)
	player_position = ground
	is_grounded = false 
	ground_velocity = new_ground_velocity
	vertical_velocity = new_vertial_velocity

func _physics_process(delta):
	time += delta
	update_position(delta)
	check_hit_ground()
	set_perspective()

func update_position(delta):
	actual_velocity = ground_velocity * delta
	if not is_grounded:
		vertical_velocity += GRAVITY * delta
		actual_velocity += Vector2(0, vertical_velocity) * delta
	shadow.global_position += ground_velocity * delta
	projectile.move_and_collide(actual_velocity)


func check_hit_ground():
	if projectile.position.y + 3 > shadow.position.y and not is_grounded:
		is_grounded = true
		destroy()

func set_perspective():
	if direction == Vector2.UP:
		z_index = 0
		if shadow.global_position.y < player_position.y:
			shadow.visible = true
	if direction == Vector2.DOWN:
		z_index = 1
		if shadow.global_position.y > player_position.y:
			shadow.visible = true
	if direction == Vector2.RIGHT or direction == Vector2.LEFT:
		z_index = 1
		shadow.visible = true
		
func destroy():
	pass
	
func get_closest_cardinal_direction(target_direction: Vector2):
	var dot_up = target_direction.dot(Vector2.UP)
	var dot_down = target_direction.dot(Vector2.DOWN)
	var dot_right = target_direction.dot(Vector2.RIGHT)
	var dot_left = target_direction.dot(Vector2.LEFT)
	
	var max_dot = max(dot_up, dot_down, dot_right, dot_left)
	if max_dot == dot_up:
		return Vector2.UP
	elif max_dot == dot_down:
		return Vector2.DOWN
	elif max_dot == dot_right:
		return Vector2.RIGHT
	elif max_dot == dot_left:
		return Vector2.LEFT
	
	return Vector2.ZERO
