extends Node2D

@onready var streetlights = $Lights.get_children()
@onready var dayNightCycle = $DayNightCycle

func _ready():
	var currTimeIndex = dayNightCycle.currentTimeIndex
	if currTimeIndex == Types.GameTime.DAY or  currTimeIndex == Types.GameTime.DUSK:
		for streetlight in streetlights:
			streetlight.hide()
	elif currTimeIndex == Types.GameTime.NIGHT or currTimeIndex == Types.GameTime.DAWN:
		for streetlight in streetlights:
			streetlight.show()	
	

func _on_day_night_cycle_time_changed(time):
	var display_string : String = "%02d:%02d" % [time.hour, time.minute]
	$UI/Control/ColorRect/Label.text = display_string

func _on_day_night_cycle_sun_changed(solar_alt):
	if solar_alt == Types.GameTime.DAY:
		for streetlight in streetlights:
			streetlight.hide()
	elif solar_alt == Types.GameTime.NIGHT:
		for streetlight in streetlights:
			streetlight.show()	
