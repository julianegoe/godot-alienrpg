class_name Player extends CharacterBody2D

@export var camera: Camera2D
@export var skill_resource: SkillResource
@export var items: ItemBarResource

@onready var tilemap = $"../../Tilemap"
@onready var remote_transform_speechbuble = $RemoteTransformSpeechbubble
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine as PlayerStateMachine
@onready var speechbubble = $Ui/Node2D/Speechbubble

var has_perm_damage_for: int = 0

func _ready():
	Events.status_zero.connect(_on_status_zero)
	Events.item_equipped.connect(_on_item_equipped)
	player_state_machine.init(self)
	var door_ways = get_tree().get_nodes_in_group("DoorWays")
	for door in door_ways:
		door.blocked.connect(_on_door_blocked)

func _on_mouse_entered() -> void:
	player_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	player_state_machine.on_mouse_exited()

func _on_input_event(viewport, event, shape_idx):
	player_state_machine.on_input_event(viewport, event, shape_idx)

func _input(event: InputEvent) -> void:
	player_state_machine.on_input(event)                                                                                

func _on_status_zero(type: Types.Status):
	player_state_machine.on_status_zero(type) 
	
func _on_door_blocked():
	speechbubble.activate(2)

func _on_item_equipped(ability: AbilityResource):
	player_state_machine.on_item_equipped(ability) 
	
