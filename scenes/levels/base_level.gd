class_name BaseLevel extends Node2D

var hand_cursor = preload("res://assets/cursors/arrow_outlined.png")
@onready var camera_2d = $Characters/Player/Camera2D
@onready var player = $Characters/Player
@onready var day_night_cycle = $"/root/DayNightCycle"
@onready var hot_bar = $Ui/HotBar
@onready var inventory = $Ui/Inventory
@onready var characters_container = $Characters
@onready var ui: CanvasLayer = $Ui

@export var level_dimension: Vector2 = Vector2(10000000, 10000000)
@export var scene_location: Types.LocationType = Types.LocationType.DEFAULT

func _ready():
	ui.show()
	Input.set_custom_mouse_cursor(hand_cursor, Input.CURSOR_POINTING_HAND)
	camera_2d.limit_right = level_dimension.x
	camera_2d.limit_bottom = level_dimension.y
	EventBus.dialogue_started.connect(_on_dialogue_started)
	EventBus.dialogue_ended.connect(_on_dialogue_ended)
	set_location_properties()
	day_night_cycle.init()
	if NavigationManager.door_tag:
		_on_level_spawn(NavigationManager.door_tag)
		
func _on_level_spawn(door_tag: String):
	var door = find_child(door_tag)
	player.global_position = door.spawn_marker.global_position

func set_location_properties():
	DayNightCycle.current_scene_location = scene_location
	match scene_location:
		Types.LocationType.INDOORS:
			hot_bar.disabled = true
		Types.LocationType.FOREST:
			hot_bar.disabled = false
		Types.LocationType.DEFAULT:
			hot_bar.disabled = false

func _on_dialogue_started():
	match scene_location:
		Types.LocationType.INDOORS:
			hot_bar.disabled = true
		Types.LocationType.FOREST:
			hot_bar.disabled = true
		Types.LocationType.DEFAULT:
			hot_bar.disabled = true

func _on_dialogue_ended():
	match scene_location:
		Types.LocationType.INDOORS:
			hot_bar.disabled = true
		Types.LocationType.FOREST:
			hot_bar.disabled = false
		Types.LocationType.DEFAULT:
			hot_bar.disabled = false
