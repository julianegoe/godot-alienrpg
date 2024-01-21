extends CanvasLayer

@onready var animation_player = $AnimationPlayer

const level_a_1 = preload("res://scenes/levels/level_a_1.tscn")
const level_a_2 = preload("res://scenes/levels/level_a_2.tscn")
var scene_to_load: PackedScene
var spawn_door_tag: String

func _ready():
	hide()
	
func change_scene(resource: PackedScene):
	get_tree().change_scene_to_packed(resource)

func go_to_level(level_tag: Types.Levels, destination_tag: String):
	show()
	match level_tag:
		Types.Levels.A1:
			scene_to_load = level_a_1
		Types.Levels.A2:
			scene_to_load = level_a_2
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		animation_player.play("fade_out")
		await animation_player.animation_finished
		change_scene(scene_to_load)
		hide()
