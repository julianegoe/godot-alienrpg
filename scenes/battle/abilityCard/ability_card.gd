class_name AbilityCard extends Control

signal activated(card: AbilityCard)
signal played(card: AbilityCard)

@export var ability: AbilityResource
@onready var card = $TextureButton
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine

func _ready():
	card_state_machine.init(self)
	card.texture_normal = ability.texture
	card.texture_disabled = ability.texture_disabled

func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()

func _on_texture_button_pressed():
	card_state_machine.on_texture_button_pressed()
