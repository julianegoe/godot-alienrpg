class_name Player extends CharacterBody2D

signal defeated

@export var camera: Camera2D
@export var health: HealthResource
@export var skill_resource: SkillResource
@export var ability_cards: MenuResource

@onready var tilemap = $"../../Tilemap"
@onready var remote_transform_speechbuble = $RemoteTransformSpeechbubble
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine as PlayerStateMachine
@onready var speechbubble = $Ui/Node2D/Speechbubble
@onready var health_ui = $Ui/Node2D2/HealthUi
@onready var progress_bar = $Ui/Node2D2/HealthUi/HealthBar
@onready var health_label = $Ui/Node2D2/HealthUi/HealthLabel

var has_perm_damage_for: int = 0

func _ready():
	progress_bar.value = health.health
	Events.battle_started.connect(_on_battle_started)
	Events.battle_finished.connect(_on_battle_finished)
	health.health_changed.connect(_on_health_changed)
	player_state_machine.init(self)
	var door_ways = get_tree().get_nodes_in_group("DoorWays")
	for door in door_ways:
		door.blocked.connect(_on_door_blocked)

func take_damage(value: int):
	print("player take damage ", str(value))
	health.health -= value
	take_perm_damage(has_perm_damage_for)
	if health.health == 0:
		defeated.emit()

func take_perm_damage(value: int):
	print("player take perm damage ", str(value))
	has_perm_damage_for = value
	if has_perm_damage_for > 0:
		health.health -= value
		if health.health == 0:
			defeated.emit()
	else:
		return

func skip_turn(_value):
	pass
	
func _on_mouse_entered() -> void:
	player_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	player_state_machine.on_mouse_exited()

func _on_input_event(viewport, event, shape_idx):
	player_state_machine.on_input_event(viewport, event, shape_idx)

func _input(event: InputEvent) -> void:
	player_state_machine.on_input(event)                                                                                
	
func _on_battle_started(_enemy):
	player_state_machine.on_battle_started(_enemy)   

func _on_battle_finished():
	player_state_machine.on_battle_finished()  
	
func _on_door_blocked():
	speechbubble.activate(2)

func _on_health_changed(value: int):
	var tween = create_tween()
	await tween.tween_property(progress_bar, "value", value, 0.5).finished
	health_label.text = str(value)
