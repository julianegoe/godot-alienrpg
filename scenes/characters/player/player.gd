class_name Player extends CharacterBody2D

@export var camera: Camera2D
@export var health: HealthResource
@export var skill_resource: SkillResource
@export var ability_cards: MenuResource

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine as PlayerStateMachine
@onready var speechbubble = $Ui/Node2D/Speechbubble

var currentVelocity : Vector2 = Vector2.ZERO

func _ready():
	player_state_machine.init(self)

func _on_mouse_entered() -> void:
	player_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	player_state_machine.on_mouse_exited()

func _on_input_event(viewport, event, shape_idx):
	player_state_machine.on_input_event(viewport, event, shape_idx)

func _input(event: InputEvent) -> void:
	player_state_machine.on_input(event)                                                                               
