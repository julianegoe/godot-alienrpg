class_name Lights extends Node2D

var lights_array: Array[Node]

func _ready():
	DayNightCycle.sun_changed.connect(_on_sun_change)
	lights_array = get_children(false)
	var currTimeIndex = DayNightCycle.game_time.current_time_index
	if currTimeIndex == Types.GameTime.DAY or  currTimeIndex == Types.GameTime.DUSK:
		for light in lights_array:
			light.hide()
	elif currTimeIndex == Types.GameTime.NIGHT or currTimeIndex == Types.GameTime.DAWN:
		for light in lights_array:
			light.show()	

func _on_sun_change(solar_alt):
	if solar_alt == Types.GameTime.DAY:
		for light in lights_array:
			light.hide()
	elif solar_alt == Types.GameTime.NIGHT:
		for light in lights_array:
			light.show()	
