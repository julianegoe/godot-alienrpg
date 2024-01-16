extends Node2D

@onready var player: Player = $Player
@onready var camera: Camera2D = $Player/Camera2D
@onready var streetlights = $Lights.get_children()
@onready var dayNightCycle = $DayNightCycle
@onready var battle_area = $BattleArea


func _ready():
	battle_area.hide()
	var currTimeIndex = dayNightCycle.currentTimeIndex
	if currTimeIndex == Types.GameTime.DAY or  currTimeIndex == Types.GameTime.DUSK:
		for streetlight in streetlights:
			streetlight.hide()
	elif currTimeIndex == Types.GameTime.NIGHT or currTimeIndex == Types.GameTime.DAWN:
		for streetlight in streetlights:
			streetlight.show()	
	

func _on_day_night_cycle_time_changed(time):
	var display_string : String = "%02d:%02d" % [time.hour, time.minute]
	$TimeUI/Control/ColorRect/Label.text = display_string

func _on_day_night_cycle_sun_changed(solar_alt):
	if solar_alt == Types.GameTime.DAY:
		for streetlight in streetlights:
			streetlight.hide()
	elif solar_alt == Types.GameTime.NIGHT:
		for streetlight in streetlights:
			streetlight.show()	

	
func _on_battle_ui_finished():
	battle_area.hide()
	
func _on_battle_area_combat_started():
	battle_area.show()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(camera, "zoom", Vector2(1.5, 1.5), 0.5)
	tween.tween_property($BattleArea, "rect_pos:y", 210, 0.3)

func _on_battle_area_combat_ended():
	battle_area.hide()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(camera, "zoom", Vector2(1, 1), 0.5)
	tween.tween_property($BattleArea, "rect_pos:y", 270, 0.3)
	tween.finished.connect(_on_battle_ui_finished)
