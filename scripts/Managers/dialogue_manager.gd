extends Node
class_name DialogueManager

var textLabel: RichTextLabel
var characterName: Label

var dialogue_tree: Dictionary
var parentScene: Node
var currentTextNode: int = 0
var pause_calc: PauseCalculator = PauseCalculator.new()
var all_pauses: Array
var should_skip: bool = false

func _init(resource: DialogueResource, scene):
	parentScene = scene
	dialogue_tree = resource.dialogue_tree
	characterName = scene.character_name
	textLabel = scene.text_label
	textLabel.visible_characters = 0
	writeCharacterName()
	delete_answers()
	init_text()

func writeCharacterName():
	characterName.text = dialogue_tree.name
	
func writeText():
	createTimer()

func skipText():
	should_skip = true
	show_answers()
	
func nextText(node):
	delete_answers()
	if currentTextNode == dialogue_tree.dialogue.size() -1:
		if parentScene.has_method("_on_ui_close"):
			parentScene._on_ui_close()
	if dialogue_tree.dialogue[currentTextNode].endTree:
		if parentScene.has_method("_on_ui_close"):
			parentScene._on_ui_close()
	currentTextNode = clamp(node, 0, dialogue_tree.dialogue.size() -1)
	init_text()
	writeText()

func show_answers():
	var answers = dialogue_tree.dialogue[currentTextNode].answers
	if parentScene.answer_container.get_child_count() > 0:
		return
	if answers.size() > 0:
		for answer in answers:
			var button = Button.new()
			button.text = answer.text
			button.flat = true
			button.add_theme_font_size_override("font_size", 6)
			button.add_theme_color_override("font_color", Color(0, 0, 0, 1))
			button.add_theme_color_override("font_pressed_color", Color(0, 0, 0, 1))
			button.add_theme_color_override("font_hover_color", Color(0, 0, 0, 0.7))
			button.add_theme_font_override("font", load("res://assets/fonts/VT323-Regular.ttf"))
			parentScene.answer_container.add_child(button)
			button.button_down.connect(_on_answer_button_pressed.bind(answer))
	else:
		parentScene.next_button.show()
		
func delete_answers():
	parentScene.next_button.hide()
	for answer in parentScene.answer_container.get_children():
		answer.queue_free()

func reset_dialogue():
	currentTextNode = 0
	delete_answers()
	init_text()

func init_text():
	var result = pause_calc.get_pauses_from_string(dialogue_tree.dialogue[currentTextNode].text)
	all_pauses = result[0]
	textLabel.text = result[1]
	textLabel.visible_characters = 0
	should_skip = false
	
func createTimer():
	if should_skip:
		textLabel.visible_characters = -1
		return
	var duration = 0.1
	for pause in all_pauses:
		if pause.position == textLabel.visible_characters:
			duration = pause.duration
	await parentScene.get_tree().create_timer(duration).timeout
	textLabel.visible_characters += 1
	if textLabel.visible_ratio == 1:
		if parentScene.has_method("_on_text_complete"):
			parentScene._on_text_complete()
		return
	else:
		writeText()
	
func _on_answer_button_pressed(answer):
	nextText(answer.nextNode)
	parentScene.dice_roll.emit(answer.dice_roll)
	
