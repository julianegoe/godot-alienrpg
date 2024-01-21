class_name BaseLevel extends Node2D

@onready var player = $Characters/Player
@onready var menu = $Menu

func _ready():
	if NavigationManager.spawn_door_tag:
		_on_level_spawn(NavigationManager.spawn_door_tag)
		
func _on_level_spawn(destination: String):
	var door_path = "DoorWays/Door_" + destination
	var node = get_node(door_path)
	player.global_position = node.spawn_marker.global_position

