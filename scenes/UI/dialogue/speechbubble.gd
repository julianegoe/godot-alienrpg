class_name Speechbubble extends Control

signal choices_prompted(choices)
signal dialogue_ended

const DEFAULT_SIZE: Vector2 = Vector2(63, 25)
var is_active: bool = false

@export var character_name_label: Label
@export var dialogue_label: RichTextLabel
@export var dialogue_resource: DialogueResource

@onready var v_box_container = $VBoxContainer
@onready var dialogue_manager = $DialogueManager

func _ready():
	dialogue_manager.init(dialogue_resource)
	custom_minimum_size = DEFAULT_SIZE
	deactivate()
	
func activate(dialogue_node: int = 0):
	EventBus.dialogue_started.emit()
	size = DEFAULT_SIZE
	is_active = true
	character_name_label.text = dialogue_manager.get_character_name()
	set_label_text(dialogue_node)
	show()
	dialogue_manager.stream_text(dialogue_label)
	
func deactivate():
	EventBus.dialogue_ended.emit()
	is_active = false
	set_label_text(0)
	hide()

func speed_up_text():
	dialogue_manager.should_skip = true
	
func slow_down_text():
	dialogue_manager.should_skip = false
	
func set_label_text(node: int = 0):
	dialogue_label.text = dialogue_manager.get_dialogue_for(node)
	dialogue_label.visible_characters = 0
	
func _on_dialogue_manager_text_completed(dialogue_node):
	slow_down_text()
	if dialogue_node.choices.is_empty() and not dialogue_node.nextNode:
		await get_tree().create_timer(1).timeout
		deactivate()
		dialogue_ended.emit()
	elif not dialogue_node.choices.is_empty():
		choices_prompted.emit(dialogue_manager.get_choices())
	else:
		await get_tree().create_timer(0.5).timeout
		set_label_text(dialogue_node.nextNode)
		dialogue_manager.stream_text(dialogue_label)

func _on_dialogue_text_item_rect_changed():
	if dialogue_label and v_box_container:
		size.y = dialogue_label.size.y + 15

