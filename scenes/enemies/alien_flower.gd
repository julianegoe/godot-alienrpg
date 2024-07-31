class_name AlienFlower extends Enemy

signal has_died

@onready var health: int = resource.health:
	set(value):
		health = clamp(health - value,0, 1000)
		if health == 0:
			has_died.emit(self)
			queue_free()

@onready var animation_player = $AnimationPlayer
	
func take_damage(amount: int):
	animation_player.play("hit")
	player.camera.apply_shake(1.0, 9.0)
	health = amount
