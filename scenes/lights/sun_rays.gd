class_name Sun extends Node2D

var rays: ColorRect

func _ready():
	rays = $rays
	DayNightCycle.sun_changed.connect(_on_sun_change)
	var currTimeIndex = DayNightCycle.game_time.current_time_index
	if currTimeIndex == Types.GameTime.DAY or  currTimeIndex == Types.GameTime.DUSK:
		set_shader_value(0.4)
	elif currTimeIndex == Types.GameTime.NIGHT or currTimeIndex == Types.GameTime.DAWN:
		set_shader_value(0.0)

func _on_sun_change(solar_alt):
	if solar_alt == Types.GameTime.DAY:
		await tween_sun(0.0, 0.4)
	elif solar_alt == Types.GameTime.NIGHT:
		await tween_sun(0.4, 0.0)


func tween_sun(start_value: float, end_value: float):
	var tween = create_tween()
	tween.tween_method(set_shader_value, start_value, end_value, 1.8);
	await tween.finished	

func set_shader_value(value):
	rays.material.set_shader_parameter("visibility", value);
