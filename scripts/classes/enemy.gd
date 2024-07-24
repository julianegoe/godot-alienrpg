class_name Enemy extends CharacterBody2D

@export var resource: EnemyResource

@onready var player: Player = %Player

func set_animation_for(_direction: Vector2):
	pass
	
func pursuit():
	pass
	
func startled():
	pass
		
func attack():
	pass

func take_damage(_damage: int):
	pass

func defeated():
	pass
