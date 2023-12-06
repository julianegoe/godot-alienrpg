class_name Speechbubble
extends Panel

@onready var text_label: RichTextLabel = %CharacterText
@onready var character_name: Label = %CharacterName
@onready var answer_container: HBoxContainer = %AnswerContainer
@onready var next_button: TextureButton = %NextButton
@onready var next_button_container = $NextButtonContainer		
@onready var margin_container: MarginContainer = $MarginContainer

func _ready():
	hide()
	next_button.hide()

func _on_margin_container_item_rect_changed():
	if text_label:
		size.y = margin_container.size.y
		next_button_container.position.y = size.y - 10
