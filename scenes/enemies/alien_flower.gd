class_name AlienFlower extends CharacterBody2D

signal has_died

@export var resource: EnemyResource

var health: int = 1000:
	set(value):
		health = clamp(health - value,0, 1000)
		if health == 0:
			has_died.emit(self)
			queue_free()

@onready var animation_player = $AnimationPlayer

func take_damage(amount: int):
	animation_player.play("hit")
	health = amount
