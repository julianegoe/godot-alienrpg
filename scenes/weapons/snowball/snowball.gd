class_name Snowball extends Projectile

@onready var explosion = $AnimatableBody2D/Explosion

func destroy():
	ground_velocity = Vector2.ZERO
	actual_velocity = Vector2.ZERO
	explosion.emitting = true
	await explosion.finished
	queue_free()
