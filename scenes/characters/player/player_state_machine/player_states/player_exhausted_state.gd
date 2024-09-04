class_name PlayerExhaustedState extends PlayerState

func enter():
	player.debug_label.text = "EXHAUSTED"
	set_exhaused(true)

func exit():
	set_exhaused(false)

func set_exhaused(value: bool):
	player.animation_tree["parameters/conditions/exhausted"] = value

func update_blend_position(direction: Vector2):
		player.animation_tree["parameters/exhaused/blend_position"] = direction
