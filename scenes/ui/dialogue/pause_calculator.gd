class_name PauseCalculator
extends Node

const PAUSE_PATTERN := "({p=\\d([.]\\d+)?[}])"
var pause_regex := RegEx.new()

class Pause:
	var position: int
	var duration: float

var all_pauses: Array[Pause]
var adjusted_string: String

func _init():
	pause_regex.compile(PAUSE_PATTERN)
	# pauses.append(Pause.new())

func get_pauses_from_string(string: String):
	adjusted_string = pause_regex.sub(string, "", true)
	var pauses = pause_regex.search_all(string)
	for pause in pauses:
		var pause_obj = Pause.new()
		pause_obj.position = adjust_pause_position(string, pause.get_start())
		pause_obj.duration = extract_pause_duration(pause.get_string())
		all_pauses.append(pause_obj)
	return [all_pauses, adjusted_string]


func extract_pause_duration(string: String):
	var regex = RegEx.new()
	regex.compile("{p=([\\d.]+)}")
	var duration = float(regex.search(string).get_string(1))
	return duration

func adjust_pause_position(string: String, startIndex: int):
	var regex := RegEx.new()
	regex.compile("({(.*?)})")
	
	var new_pos := startIndex
	var left_of_pos := string.left(startIndex)
	var all_prev_tags := regex.search_all(left_of_pos)
	
	for tag_result in all_prev_tags:
		new_pos -= tag_result.get_string().length()
	return new_pos
	
