class_name DialogueManager extends Node

signal uiClose
signal textComplete(data)
signal choiceSelected(data)
signal textSkipped

@onready var pause_calc: PauseCalculator = PauseCalculator.new()

@export var characterNameLabel: Label
@export var textLabel: RichTextLabel
@export var choiceButtons: Array[Button]
@export var currentTextNode: int = 0:
	get:
		return currentTextNode
	set(value):
		currentTextNode = value
		print_rich("[b]DialogueSystem:[/b] Current text node: [color=green][b]" + str(value) + "[/b][/color]") 

var dialogue_tree: Dictionary
var _all_pauses: Array
var _should_skip: bool = false:
	get:
		return _should_skip
	set(value):
		_should_skip = value
		textSkipped.emit()

func init_text():
	var result = pause_calc.get_pauses_from_string(dialogue_tree.dialogue[currentTextNode].text)
	_all_pauses = result[0]
	textLabel.text = result[1]
	textLabel.visible_characters = 0
	_should_skip = false

func writeCharacterName():
	characterNameLabel.text = dialogue_tree.name

func writeText():
	var duration = _get_typing_speed()
	await get_tree().create_timer(duration).timeout
	textLabel.visible_characters += 1
	if textLabel.visible_ratio == 1:
		textComplete.emit(dialogue_tree.dialogue[currentTextNode])
		return
	else:
		writeText()
	
func skipText():
	_should_skip = true
	
func nextText(node):
	hide_choices()
	if not node:
		uiClose.emit()
		return
	if currentTextNode == dialogue_tree.dialogue.size() -1:
		uiClose.emit()
		return
	currentTextNode = clamp(node, 0, dialogue_tree.dialogue.size() -1)
	init_text()
	writeText()

func show_choices() -> void:
	for n in range(dialogue_tree.dialogue[currentTextNode].choices.size()):
		choiceButtons[n].pressed.connect(_on_button_pressed.bind(dialogue_tree.dialogue[currentTextNode].choices[n]))
		choiceButtons[n].text = dialogue_tree.dialogue[currentTextNode].choices[n].text
		choiceButtons[n].show()
			
func hide_choices() -> void:
	for choice in choiceButtons:
		choice.hide()
		choice.text = ""
		if choice.is_connected("pressed", _on_button_pressed):
			choice.pressed.disconnect(_on_button_pressed)
	
func _on_button_pressed(data):
	choiceSelected.emit(data)

func _get_typing_speed():
	var duration = 0
	if _should_skip:
		duration = 0.01
	else:
		duration = 0.1
		for pause in _all_pauses:
			if pause.position == textLabel.visible_characters:
				duration = pause.duration
	return duration
