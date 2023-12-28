class_name Speechbubble extends Panel

signal nextButtonShow
signal nextButtonHide

@export var dialogue_resource: DialogueResource
var DEFAULT_SIZE: Vector2 = Vector2(63, 41)

@onready var characterTextLabel: RichTextLabel = %CharacterText
@onready var characterName: Label = %CharacterName
@onready var answerContainer: HBoxContainer = %ChoiceContainer
@onready var nextButtonContainer: Control = $NextButtonContainer
@onready var nextButton: TextureButton = %NextButton
@onready var marginContainer: MarginContainer = $MarginContainer

var dialogueManager: DialogueManager

enum UiState {
	OPEN,
	CLOSED,
}
var ui_state: UiState = UiState.CLOSED

func _ready():
	dialogue_resource.readJSON()
	dialogueManager = $DialogueManager
	deactivate()

func activate():
	size = DEFAULT_SIZE
	show()
	ui_state = UiState.OPEN
	nextButton.hide()
	dialogueManager.dialogue_tree = dialogue_resource.dialogue_tree
	dialogueManager.currentTextNode = 0
	dialogueManager.init_text()
	dialogueManager.writeText()

func _on_margin_container_item_rect_changed():
	if characterTextLabel:
		size.y = marginContainer.size.y + 5
	
func skip_text():
	dialogueManager.skipText()

func next_text(node):
	dialogueManager.nextText(node)

func deactivate():
	hide()
	dialogueManager.hide_choices()
	ui_state = UiState.CLOSED
	
func _on_next_button_pressed():
	dialogueManager.nextText(nextButton.nextNode)
	nextButton.hide()
	nextButtonHide.emit()

func _on_dialogue_manager_ui_close():
	deactivate()

func _on_dialogue_manager_text_complete(data):
	await get_tree().create_timer(0.25).timeout
	if data.choices.size() > 0:
		dialogueManager.show_choices()
	elif data.nextNode:
		nextButton.nextNode = data.nextNode
		nextButton.show()
		nextButtonShow.emit()
	else:
		nextButton.nextNode = null
		nextButton.show()
		nextButtonShow.emit()

func _on_dialogue_manager_choice_selected(data):
	if data.nextNode:
		dialogueManager.nextText(data.nextNode)
	else:
		deactivate()
