extends Node

func get_attack_damage_from(base_damage, base_strength, strength_modifier, charge_modifier):
	var damage  = base_damage + (base_strength * strength_modifier) * (1 + charge_modifier) 
	return damage

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
