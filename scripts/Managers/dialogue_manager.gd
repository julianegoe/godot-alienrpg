class_name DialogueManager extends Node

signal text_completed(current_node)
signal text_skipped

@export var current_text_node: int = 0:
	set(value):
		current_text_node = value
		print_rich("[b]DialogueSystem:[/b] Current text node: [color=green][b]" + str(value) + "[/b][/color]") 

var dialogue_resource: DialogueResource
var should_skip: bool = false:
	get:
		return should_skip
	set(value):
		should_skip = value
		text_skipped.emit()
var _all_pauses: Array
var current_dialogue_string: String

@onready var pause_calc: PauseCalculator = PauseCalculator.new()

func init(resource: DialogueResource):
	dialogue_resource = resource
	
func get_character_name():
	return dialogue_resource.display_name

func get_dialogue_for(node: int) -> String:
	current_text_node = node
	var result = pause_calc.get_pauses_from_string(dialogue_resource.dialogue[current_text_node].text)
	_all_pauses = result[0]
	current_dialogue_string = result[1]
	return current_dialogue_string

func get_choices():
	return dialogue_resource.dialogue[current_text_node].choices
	
func set_next_node(next_node: int):
	current_text_node = next_node
	
func stream_text(label: Node):
	var duration = _get_typing_speed(label)
	await get_tree().create_timer(duration).timeout
	label.visible_characters += 1
	if label.visible_ratio == 1:
		text_completed.emit(dialogue_resource.dialogue[current_text_node])
		return
	else:
		stream_text(label)
		

func _get_typing_speed(label: Node):
	var duration = 0
	if should_skip:
		duration = 0.01
	else:
		duration = 0.1
		for pause in _all_pauses:
			if pause.position == label.visible_characters:
				duration = pause.duration
	return duration
