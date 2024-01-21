class_name AbilityCard extends Control

signal card_activated(card: AbilityResource)

@export var card_resource: AbilityResource
@onready var card = $TextureButton
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine

func _ready():
	card_state_machine.init(self)
	card.texture_normal = card_resource.texture

func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()

func _on_texture_button_pressed():
	card_state_machine.on_texture_button_pressed()
