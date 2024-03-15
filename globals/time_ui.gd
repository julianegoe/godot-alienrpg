extends CanvasLayer

@onready var clock = $Control/MarginContainer/Clock
@onready var label = $Control/MarginContainer/Label

func _ready():
	DayNightCycle.time_changed.connect(_on_time_changed)
	DayNightCycle.sun_changed.connect(_on_sun_changed)
	label.text = DayNightCycle.game_time.current_display_time
	clock.texture = clock.get_frame_at(DayNightCycle.game_time.current_time_index)

func _on_time_changed(display_time):
	label.text = display_time

func _on_sun_changed(sun: Types.GameTime):
	clock.texture = clock.get_frame_at(sun)
