class_name GameTimeResource extends Resource

@export var current_time_index: Types.GameTime = Types.GameTime.DAY

var time_lookup: Dictionary = {
	Types.GameTime.NIGHT: { "hour": 20, "minute": 0, "second": 0},
	Types.GameTime.DAWN: { "hour": 5, "minute": 0, "second": 0},
	Types.GameTime.DAY:  { "hour": 9, "minute": 0, "second": 0},
	Types.GameTime.DUSK: { "hour": 17, "minute": 0, "second": 0},
}

var color_lookup: Dictionary = {
	Types.GameTime.DAWN: Color(0.39, 0.51, 0.64, 1),
	Types.GameTime.DAY: Color.WHITE,
	Types.GameTime.DUSK: Color(0.922, 0.765, 0.765, 1),
	Types.GameTime.NIGHT: Color(0.168, 0.176, 0.322, 1),
}

var current_display_time: String = ""
var current_time_in_seconds: int = time_lookup[current_time_index].hour * 3600
var current_time_dict = time_lookup[current_time_index]:
	set(value):
		current_time_dict = value
		current_display_time = _time_object_to_display_time(current_time_dict)
	get:
		return current_time_dict


func _time_object_to_display_time(time: Dictionary):
	return "%02d:%02d" % [time.hour, time.minute]
