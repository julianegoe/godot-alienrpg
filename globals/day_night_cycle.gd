extends CanvasModulate

signal time_changed(formatted_time)
signal sun_changed(solar_alt)

enum LOCATION_TYPE { DEFAULT, FOREST, INDOORS }

@export var game_time: GameTimeResource

var current_scene_location: LOCATION_TYPE = LOCATION_TYPE.DEFAULT

@onready var canvas_modulate: CanvasModulate = self
@onready var timer: Timer = $Timer

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

func _ready():
	game_time.current_time_in_seconds = time_lookup[game_time.current_time_index].hour * 3600
	game_time.current_time_dict = Time.get_time_dict_from_unix_time(game_time.current_time_in_seconds)
	game_time.current_display_time = _time_object_to_display_time(game_time.current_time_dict)

func init():
	color = modulate_color(color_lookup[game_time.current_time_index])
	game_time.current_display_time = _time_object_to_display_time(game_time.current_time_dict)

func tween_color(new_color: Color):
	var tween = get_tree().create_tween()
	tween.tween_property(canvas_modulate,"color",new_color, 2.5)

func modulate_color(base_color: Color):
	match current_scene_location:
		LOCATION_TYPE.FOREST:
			return base_color.darkened(0.4)
		LOCATION_TYPE.DEFAULT:
			return base_color
			
func _on_timer_timeout():
	game_time.current_time_in_seconds += 60
	game_time.current_time_dict = Time.get_time_dict_from_unix_time(game_time.current_time_in_seconds)
	time_changed.emit(_time_object_to_display_time(game_time.current_time_dict))
	if game_time.current_time_dict.hour == time_lookup[Types.GameTime.NIGHT].hour and game_time.current_time_dict.minute == time_lookup[Types.GameTime.NIGHT].minute:
		sun_changed.emit(Types.GameTime.NIGHT)
		game_time.current_time_index = Types.GameTime.NIGHT
		var calc_color = modulate_color(color_lookup[game_time.current_time_index])
		tween_color(calc_color)
	elif game_time.current_time_dict.hour == time_lookup[Types.GameTime.DAWN].hour and game_time.current_time_dict.minute == time_lookup[Types.GameTime.DAWN].minute:
		sun_changed.emit(Types.GameTime.DAWN)
		game_time.current_time_index = Types.GameTime.DAWN
		var calc_color = modulate_color(color_lookup[game_time.current_time_index])
		tween_color(calc_color)
	elif game_time.current_time_dict.hour == time_lookup[Types.GameTime.DAY].hour and game_time.current_time_dict.minute == time_lookup[Types.GameTime.DAY].minute:
		sun_changed.emit(Types.GameTime.DAY)
		game_time.current_time_index = Types.GameTime.DAY
		var calc_color = modulate_color(color_lookup[game_time.current_time_index])
		tween_color(calc_color)
	elif game_time.current_time_dict.hour == time_lookup[Types.GameTime.DUSK].hour and game_time.current_time_dict.minute == time_lookup[Types.GameTime.DUSK].minute:
		sun_changed.emit(Types.GameTime.DUSK)
		game_time.current_time_index = Types.GameTime.DUSK
		var calc_color = modulate_color(color_lookup[game_time.current_time_index])
		tween_color(calc_color)
	if game_time.current_time_dict.minute == 59:
		Events.status_changed.emit(Types.Status.ENERGY, -4)

func _time_object_to_display_time(time: Dictionary):
	return "%02d:%02d" % [time.hour, time.minute]
	
