class_name BaseLevel extends Node2D

enum LOCATION_TYPE { DEFAULT, FOREST, INDOORS }

@onready var player = $Characters/Player
@onready var menu = $Menu
@onready var day_night_cycle = $"/root/DayNightCycle"
@onready var background_music = $BackgroundMusic

@export var scene_location: LOCATION_TYPE = LOCATION_TYPE.DEFAULT
@export var music_file: AudioStreamOggVorbis

func _ready():
	background_music.stream = music_file
	background_music.play(0.0)
	day_night_cycle.current_scene_location = scene_location
	day_night_cycle.init()
	if NavigationManager.spawn_door_tag:
		_on_level_spawn(NavigationManager.spawn_door_tag)
		
func _on_level_spawn(destination: String):
	var door_path = "DoorWays/Door_" + destination
	var node = get_node(door_path)
	player.global_position = node.spawn_marker.global_position

func _on_background_music_finished():
	background_music.play(0.0)
