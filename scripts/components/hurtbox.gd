class_name HurtBox extends Area2D

enum { Off = 0, Hitboxes = 1, Hurtboxes = 2 }
enum OwnerType { CHARACTER, ENEMY }

@export var type: OwnerType

func _init() -> void:
	collision_layer = Off
	collision_mask = Hitboxes

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null:
		return
	if owner == hitbox.owner:
		return
	elif hitbox.type == type:
		return
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
	if hitbox.owner.has_method("destroy"):
		hitbox.owner.destroy()
	
	
