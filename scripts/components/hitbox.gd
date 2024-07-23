class_name HitBox extends Area2D

enum { Off = 0, Hitboxes = 1, Hurtboxes = 2 }
enum OwnerType { CHARACTER, ENEMY }

@export var type: OwnerType
@export var damage := 0

func _init():
	collision_layer = Hitboxes
	collision_mask = Off
