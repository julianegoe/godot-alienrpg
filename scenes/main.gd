extends Node2D


func _on_day_night_cycle_time_changed(time):
	var display_string : String = "%02d:%02d" % [time.hour, time.minute]
	$UI/Control/Label.text = display_string

