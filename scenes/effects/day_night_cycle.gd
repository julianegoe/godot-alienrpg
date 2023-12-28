extends CanvasModulate

signal time_changed(time)
signal sun_changed(solar_alt)

@onready var canvas_modulate: CanvasModulate = $"."
@onready var timer: Timer = $Timer

var time_lookup: Dictionary = {
	Types.GameTime.NIGHT: { "hour": 22, "minute": 0, "second": 0},
	Types.GameTime.DAWN: { "hour": 5, "minute": 0, "second": 0},
	Types.GameTime.DAY:  { "hour": 9, "minute": 0, "second": 0},
	Types.GameTime.DUSK: { "hour": 19, "minute": 0, "second": 0},
}

var color_lookup: Dictionary = {
	Types.GameTime.NIGHT: Color(0.168, 0.176, 0.322, 1),
	Types.GameTime.DAWN: Color(0.39, 0.51, 0.64, 1),
	Types.GameTime.DAY: Color.WHITE,
	Types.GameTime.DUSK: Color(0.541, 0.259, 0.396, 1),
}
@export var currentTimeIndex = Types.GameTime.DAY
var currentTimeInSeconds: int = time_lookup[currentTimeIndex].hour * 3600
var currentTimeDict = Time.get_time_dict_from_unix_time(currentTimeInSeconds)

func _ready():
	currentTimeInSeconds = time_lookup[currentTimeIndex].hour * 3600
	currentTimeDict = Time.get_time_dict_from_unix_time(currentTimeInSeconds)
	color = color_lookup[currentTimeIndex]
	time_changed.emit(currentTimeDict)

func tween_color(new_color: Color):
	var tween = get_tree().create_tween()
	tween.tween_property(canvas_modulate,"color",new_color, 2.5)

func _on_timer_timeout():
	currentTimeInSeconds += (15 * 60)
	currentTimeDict = Time.get_time_dict_from_unix_time(currentTimeInSeconds)
	time_changed.emit(currentTimeDict)
	if currentTimeDict.hour == time_lookup[Types.GameTime.NIGHT].hour and currentTimeDict.minute == time_lookup[Types.GameTime.NIGHT].minute:
		sun_changed.emit(Types.GameTime.NIGHT)
		currentTimeIndex = Types.GameTime.NIGHT
		tween_color(color_lookup[currentTimeIndex])
	elif currentTimeDict.hour == time_lookup[Types.GameTime.DAWN].hour and currentTimeDict.minute == time_lookup[Types.GameTime.DAWN].minute:
		sun_changed.emit(Types.GameTime.DAWN)
		currentTimeIndex = Types.GameTime.DAWN
		tween_color(color_lookup[currentTimeIndex])
	elif currentTimeDict.hour == time_lookup[Types.GameTime.DAY].hour and currentTimeDict.minute == time_lookup[Types.GameTime.DAY].minute:
		sun_changed.emit(Types.GameTime.DAY)
		currentTimeIndex = Types.GameTime.DAY
		tween_color(color_lookup[currentTimeIndex])
	elif currentTimeDict.hour == time_lookup[Types.GameTime.DUSK].hour and currentTimeDict.minute == time_lookup[Types.GameTime.DUSK].minute:
		sun_changed.emit(Types.GameTime.DUSK)
		currentTimeIndex = Types.GameTime.DUSK
		tween_color(color_lookup[currentTimeIndex])
