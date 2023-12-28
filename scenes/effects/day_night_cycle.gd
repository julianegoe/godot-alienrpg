extends CanvasModulate

signal time_changed(time)

@onready var canvas_modulate: CanvasModulate = $"."

enum TIME {
	NIGHT,
	DAWN,
	DAY,
	DUSK,
}

var time_lookup: Dictionary = {
	TIME.NIGHT: { "hour": 22, "minute": 0, "second": 0},
	TIME.DAWN: { "hour": 5, "minute": 0, "second": 0},
	TIME.DAY:  { "hour": 9, "minute": 0, "second": 0},
	TIME.DUSK: { "hour": 19, "minute": 0, "second": 0},
}

var color_lookup: Dictionary = {
	TIME.NIGHT: Color.MIDNIGHT_BLUE,
	TIME.DAWN: Color.WHEAT,
	TIME.DAY:  Color.WHITE,
	TIME.DUSK: Color.WEB_PURPLE
}
@export var currentTimeIndex: TIME = TIME.DAY
var currentTimeInSeconds: int = time_lookup[currentTimeIndex].hour * 3600
var currentTimeDict = Time.get_time_dict_from_unix_time(currentTimeInSeconds)

func _ready():
	currentTimeInSeconds = time_lookup[currentTimeIndex].hour * 3600
	currentTimeDict = Time.get_time_dict_from_unix_time(currentTimeInSeconds)
	color = color_lookup[currentTimeIndex]
	time_changed.emit(currentTimeDict)

func tween_color(color: Color):
	var tween = get_tree().create_tween()
	tween.tween_property(canvas_modulate,"color",color, 2)

func _on_timer_timeout():
	currentTimeInSeconds += (15 * 60)
	currentTimeDict = Time.get_time_dict_from_unix_time(currentTimeInSeconds)
	time_changed.emit(currentTimeDict)
	if currentTimeDict.hour == time_lookup[TIME.NIGHT].hour and  currentTimeDict.minute == time_lookup[TIME.NIGHT].minute:
		print("night")
		currentTimeIndex = TIME.NIGHT
		tween_color(color_lookup[currentTimeIndex])
	elif currentTimeDict.hour == time_lookup[TIME.DAWN].hour and currentTimeDict.minute == time_lookup[TIME.DAWN].minute:
		print("dawn")
		currentTimeIndex = TIME.DAWN
		tween_color(color_lookup[currentTimeIndex])
	elif currentTimeDict.hour == time_lookup[TIME.DAY].hour and currentTimeDict.minute == time_lookup[TIME.DAY].minute:
		print("day")
		currentTimeIndex = TIME.DAY
		tween_color(color_lookup[currentTimeIndex])
	elif currentTimeDict.hour == time_lookup[TIME.DUSK].hour and currentTimeDict.minute == time_lookup[TIME.DUSK].minute:
		print("dusk")
		currentTimeIndex = TIME.DUSK
		tween_color(color_lookup[currentTimeIndex])
