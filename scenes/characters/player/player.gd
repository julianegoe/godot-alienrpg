class_name Player extends CharacterBody2D

@export var camera: Camera2D
@export var stats: CharacterResource
@export var status: StatusResource

@onready var remote_transform_speechbuble: RemoteTransform2D = $RemoteTransformSpeechbubble
@onready var charge_indicator: AnimatedSprite2D = $Ui/ChargeIndicator
@onready var speechbubble = $Ui/Node2D/Speechbubble
@onready var ranged_weapon_spawner: Marker2D = $Body/RangedWeaponSpawner
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var debug_label: Label = $DebugLabel
@onready var melee_hit_box = $Body/MeleeTool/Container/HitBox
@onready var choices_box = $ChoicesUi/Choices/ChoicesBox
@onready var body = $Body

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine as PlayerStateMachine

var equipped_item_type: ItemResource.ItemType = ItemResource.ItemType.NONE
var equipped_item: ItemResource:
	set(value):
		if value:
			equipped_item = value
			equipped_item_type = equipped_item.type
		else:
			equipped_item_type = ItemResource.ItemType.NONE
			equipped_item = null
var weapon_target_position: Vector2
var ranged_attack_strength: float
var melee_attack_strength: float

func _ready():
	player_state_machine.init(self)
	var door_ways = get_tree().get_nodes_in_group("LevelTeleporter")
	for door in door_ways:
		door.blocked.connect(_on_door_blocked)
	InventoryManager.item_equipped.connect(_on_item_equipped)
	InventoryManager.item_removed.connect(_on_item_removed)

func take_damage(damage: int):
	var tween = get_tree().create_tween()
	tween.tween_method(set_damage_shader_value, 0.04, 0.0, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BOUNCE) 
	camera.apply_shake()
	status.health -= damage
	if status.health == 0:
		_on_health_exhausted()
	
func _unhandled_input(event: InputEvent) -> void:
	player_state_machine.on_input(event)   
	
func _on_attack_animation_finished():
	player_state_machine.on_attack_animation_finished()

func _on_attack_ranged_start():
	player_state_machine.on_attack_ranged_start()

func _on_charge_start():
	player_state_machine.on_charge_start()
	
func _on_item_equipped(item: ItemResource):
	equipped_item = item
	player_state_machine.on_item_equipped(item)

func _on_item_removed(item: ItemResource):
	if item.hotbar_quantity == 0:
		equipped_item = null
	
func _on_door_blocked():
	speechbubble.activate(2)

func _on_health_exhausted():
	player_state_machine.on_health_exhausted()
	
func _physics_process(delta):
	charge_indicator.position = get_global_mouse_position()
	player_state_machine.physics_update(delta)

func _on_charge_indicator_animation_finished():
	player_state_machine.on_charge_indicator_animation_finished()

func _create_choices_buttons(choices):
	var prob: String
	for choice in choices:
		if !!choice.dice_roll:
			prob = str(choice.dice_roll.calculate_probability()) + "%"
		else:
			prob = ""
		var button_scene = load("res://scenes/ui/dialogue/choice_button.tscn")
		var button = button_scene.instantiate()
		button.text = choice.text + " " + prob
		button.pressed.connect(_on_choice_selected.bind(choice))
		choices_box.choices_container.add_child(button)

func _on_choice_selected(choice):
	var success: bool = true
	if choice.dice_roll:
		success = await DiceRoll.execute(choice.dice_roll)
	if choice.next_node and success:
		speechbubble.activate(choice.next_node.success)
	elif choice.next_node and not success:
		speechbubble.activate(choice.next_node.failure)
	else:
		choices_box.hide()
		speechbubble.deactivate()
	for choice_button in choices_box.choices_container.get_children():
		choice_button.queue_free()

func _on_speechbubble_choices_prompted(choices):
	_create_choices_buttons(choices)
	choices_box.show()

func _on_speechbubble_dialogue_ended():
	choices_box.hide()

func set_damage_shader_value(value: float):
	body.material.set_shader_parameter("amount", value);
