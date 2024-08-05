extends Node2D

var input_direction: Vector2 = Vector2.ZERO
var current_rotation: int = 0

func input_direction_to_orientation():
	#var tween = get_tree().create_tween()
	#tween.tween_property($Needle, "rotation_degrees", rad_to_deg(input_direction.angle()), 0.5).set_ease(Tween.EASE_IN_OUT)

	if input_direction == Vector2.RIGHT:
		var tween = get_tree().create_tween()
		tween.tween_property($".", "rotation_degrees", wrapi(-90, 0, 360), 0.5).set_ease(Tween.EASE_IN_OUT)
	if input_direction == Vector2.DOWN:
		var tween = get_tree().create_tween()
		tween.tween_property($".", "rotation_degrees", wrapi(-180, 0, 360), 0.5).set_ease(Tween.EASE_IN_OUT)
	if input_direction == Vector2.LEFT:
		var tween = get_tree().create_tween()
		tween.tween_property($".", "rotation_degrees", wrapi(90, 0, 360), 0.5).set_ease(Tween.EASE_IN_OUT)
	if input_direction == Vector2.UP:
		var tween = get_tree().create_tween()
		tween.tween_property($".", "rotation_degrees", wrapi(360, 0, 360), 0.5).set_ease(Tween.EASE_IN_OUT)

func _process(delta):
	input_direction = Input.get_vector("left", "right", "up", "down")
	input_direction_to_orientation()


		
	
