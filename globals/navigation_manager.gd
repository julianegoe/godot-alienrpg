extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func _ready():
	hide()
	
const level_a_1 = preload("res://scenes/levels/level_a_1.tscn")
const level_a_2 = preload("res://scenes/levels/level_a_2.tscn")

var spawn_door_tag: String

func go_to_level(level_tag: Types.Levels, destination_tag: String):
	show()
	var scene_to_load
	match level_tag:
		Types.Levels.A1:
			scene_to_load = level_a_1
		Types.Levels.A2:
			scene_to_load = level_a_2
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		animation_player.play("fade_out")
		await animation_player.animation_finished
		get_tree().change_scene_to_packed(scene_to_load)
		animation_player.play("fade_in")
		hide()
