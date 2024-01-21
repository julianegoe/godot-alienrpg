class_name Icon extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

@export var sprite_texture: Texture:
	get:
		return sprite_texture
	set(value):
		sprite_texture = value
		sprite = $Sprite2D
		sprite.texture = value

func play_animation():
	$AnimationPlayer.play("jump")

