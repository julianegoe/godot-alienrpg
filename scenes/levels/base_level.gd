class_name BaseLevel extends Node2D

@onready var camera_2d = $Characters/Player/Camera2D
@onready var player = $Characters/Player
@onready var day_night_cycle = $"/root/DayNightCycle"
@onready var background_music = $BackgroundMusic
@onready var hot_bar = $Ui/HotBar
@onready var inventory = $Ui/Inventory
@onready var characters_container = $Characters
@onready var skill_checker = $SkillChecker

@export var level_dimension: Vector2 = Vector2(10000000, 10000000)
@export var scene_location: Types.LocationType = Types.LocationType.DEFAULT
@export var music_file: AudioStreamOggVorbis

func _ready():
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
	
func _on_background_music_finished():
	background_music.play(0.0)

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

#func _on_inventory_inventory_visibility_changed(value):
	#if value:
		#get_tree().paused = value
	#else:
		#get_tree().paused = value
