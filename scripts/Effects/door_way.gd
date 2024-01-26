class_name DoorWay extends Area2D

signal blocked

@export var destination_scene: Types.Levels
@export var destination_door: String
@export var spawn_direction = "down"
@export var is_open: bool = true

@onready var spawn_marker = $SpawnMarker

func _on_body_entered(body):
	if body is Player and is_open:
		NavigationManager.go_to_level(destination_scene, destination_door)
	else:
		blocked.emit()
		
