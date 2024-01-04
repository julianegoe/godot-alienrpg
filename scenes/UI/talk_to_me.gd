extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

@export var sprite_texture: Texture2D:
	get:
		return sprite_texture
	set(value):
		sprite_texture = value
		sprite.texture = value

func play_animation():
	$AnimationPlayer.play("jump")

