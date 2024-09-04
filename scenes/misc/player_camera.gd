class_name PlayerCamera extends Camera2D

@export var start_strength: float = 4.0
@export var shake_fade: float = 8

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0

func apply_shake(strength: float = start_strength, fade: float = shake_fade):
	shake_strength = strength
	shake_fade = fade

func random_offset():
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))

func _process(delta):
	if shake_strength > 0:
		shake_strength = lerp(shake_strength, 0.0, shake_fade * delta)
		offset = random_offset()
