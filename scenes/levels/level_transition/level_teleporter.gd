class_name LevelTeleporter extends Area2D

signal blocked

@export var destination_scene: Types.Levels
@export_enum("N", "E", "S", "W") var destination_door: String
@export var is_open: bool = true

@onready var spawn_marker = $SpawnMarker
	
func _on_body_entered(body):
	var destination = "Door_" + destination_door
	if body is Player and is_open:
		NavigationManager.go_to_level(destination_scene, destination)
	else:
		blocked.emit()
