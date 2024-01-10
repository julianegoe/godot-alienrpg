class_name AbilityCard extends Control

signal reparent_requested(ability_card: AbilityCard)
@export var resource: AbilityResource
@onready var color: ColorRect = $ColorRect
@onready var label: Label = $ColorRect/CenterContainer/Label
@onready var drop_point_detector: Area2D = $DropPointSelector
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var targets: Array[Node] = []
@onready var parent: Control

func _ready():
	card_state_machine.init(self)

func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()

func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)

func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)

func _on_drop_point_selector_area_entered(area):
	if not targets.has(area):
		targets.append(area)

func _on_drop_point_selector_area_exited(area):
	targets.erase(area)

func animate_to_position(new_position: Vector2, duration: float):
	var tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_position", new_position, duration)
