extends Node
class_name TalkComponent

signal dice_roll(skill)
# This Component gives any Scene with a dialogue resource the ability to be talked to.
var dialogue_scene: PackedScene = preload("res://scenes/UI/speechbubble.tscn");
var talk_icon_scene: PackedScene = preload("res://scenes/UI/talk_to_me.tscn");

var dialogue_manager: DialogueManager

var speechbubble: Speechbubble
var text_label: RichTextLabel
var character_name: Label
var answer_container: HBoxContainer
var next_button: TextureButton
var talk_icon: Node2D

enum InteractionState {
	IN_VICINITY,
	UI_OPEN,
	FAR_AWAY,
}
var interaction_state: InteractionState = InteractionState.FAR_AWAY

var npc: CharacterBody2D

func _init(character: CharacterBody2D) -> void:
	npc = character
	
func _ready():
	npc.vicinity.body_entered.connect(_on_body_entered)
	npc.vicinity.body_exited.connect(_on_body_exited)
	speechbubble = dialogue_scene.instantiate()
	speechbubble.position = Vector2(-70, -64)
	speechbubble.show()
	npc.add_child(speechbubble)

func show_speechbubble() -> void:
	speechbubble.show()
	text_label = speechbubble.text_label
	answer_container = speechbubble.answer_container
	character_name = speechbubble.character_name
	next_button = speechbubble.next_button
	dialogue_manager = DialogueManager.new(npc.dialogue, self)
	dialogue_manager.writeText()
		
func _on_body_entered(body: Node2D):
	if body is Player:
		interaction_state = InteractionState.IN_VICINITY
		talk_icon = talk_icon_scene.instantiate()
		talk_icon.show()
		talk_icon.z_index = 100
		npc.add_child(talk_icon)
		talk_icon.position -= Vector2(0, 40)

func _on_body_exited(body: Node2D):
	if body is Player:
		interaction_state = InteractionState.FAR_AWAY
		talk_icon.queue_free()
		speechbubble.hide()

func _on_text_complete():
	dialogue_manager.show_answers()

func _on_skip_text():
	dialogue_manager.show_answers()
	
func _on_ui_close():
	dialogue_manager.reset_dialogue()
	speechbubble.hide()
	interaction_state = InteractionState.IN_VICINITY

func _on_next_button_pressed():
	dialogue_manager.nextText(dialogue_manager.currentTextNode + 1)

func _unhandled_key_input(event):
	if event.is_action_pressed("skip"):
		if interaction_state == InteractionState.UI_OPEN:
			dialogue_manager.skipText()
	if event.is_action_pressed("interact"):
		match interaction_state:
			InteractionState.FAR_AWAY:
				pass
			InteractionState.IN_VICINITY:
				show_speechbubble()
				interaction_state = InteractionState.UI_OPEN
			InteractionState.UI_OPEN:
				if next_button.visible:
					dialogue_manager.nextText(dialogue_manager.currentTextNode + 1)
