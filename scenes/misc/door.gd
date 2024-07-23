class_name Door extends Area2D

@export var id: String # used to get key of doors resource for unlocked/locked state
@export var destination_level: Types.Levels # level or scene this door should lead to
# suffix of door node in scene tree
@export_enum("ShopInterior", "ShopExterior", "HomeInterior", "HomeExterior") var destination_door: String

@onready var spawn_marker = $SpawnMarker

var is_locked: bool

func _ready():
	is_locked = NavigationManager.doors.locked[id]
	NavigationManager.door_locked.connect(_on_door_locked)
	NavigationManager.door_unlocked.connect(_on_door_unlocked)

func _on_door_locked(door_id: String):
	if id == door_id:
		is_locked = true

func _on_door_unlocked(door_id: String):
	if id == door_id:
		is_locked = false

func _on_body_entered(_body: Player):
	var destination = "Door_" + destination_door
	if is_locked:
		return
	else:
		NavigationManager.go_to_level(destination_level, destination)
	
