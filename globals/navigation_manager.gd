extends CanvasLayer

signal door_unlocked(door_id: String)
signal door_locked(door_id: String)

@onready var animation_player = $AnimationPlayer
@export var doors = DoorsResource

const level_a_1 = preload("res://scenes/levels/level_a_1.tscn")
const level_a_2 = preload("res://scenes/levels/level_a_2.tscn")
const level_a_3 = preload("res://scenes/levels/level_a_3.tscn")
const shop_interior = preload("res://scenes/levels/shop_interior.tscn")

var scene_to_load: PackedScene
var door_tag: String

func _ready():
	hide()

func unlock_door(door_id: String):
	doors.locked[door_id] = false
	door_unlocked.emit(door_id)

func lock_door(door_id: String):
	doors.locked[door_id] = true
	door_locked.emit(door_id)
	
func change_scene(resource: PackedScene):
	get_tree().change_scene_to_packed(resource)

func go_to_level(level_tag: Types.Levels, door: String):
	show()
	match level_tag:
		Types.Levels.A1:
			scene_to_load = level_a_1
		Types.Levels.A2:
			scene_to_load = level_a_2
		Types.Levels.A3:
			scene_to_load = level_a_3
		Types.Levels.SHOP:
			scene_to_load = shop_interior
	door_tag = door
	if scene_to_load != null:
		animation_player.play("fade_out")
		await animation_player.animation_finished
		change_scene(scene_to_load)
		hide()
