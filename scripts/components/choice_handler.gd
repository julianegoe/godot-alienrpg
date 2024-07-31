class_name ChoiceHandler extends Node2D

@export var choices_container: Node
@export var speechbubble: Speechbubble

func _ready():
	speechbubble.choices_prompted.connect(_on_dialoge_choices_prompted)
	
func _create_choices_buttons(choices):
	for choice in choices:
		var button = Button.new()
		button.pressed.connect(_on_choice_selected.bind(choice))
		button.theme = load("res://resources/themes/font_main_theme.tres")
		button.text = choice.text
		choices_container.add_child(button)

func _on_choice_selected(choice):
	if choice.next_node:	
		speechbubble.activate(choice.nextNode)
	else:
		speechbubble.deactivate()
	for choice_button in choices_container.get_children():
		choice_button.queue_free()

func _on_dialoge_choices_prompted(choices):
	_create_choices_buttons(choices)
