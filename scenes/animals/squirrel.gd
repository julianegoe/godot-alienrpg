extends CharacterBody2D

var currentVelocity = Vector2.RIGHT * 2

func _ready():
	$AnimationPlayer.play("jump")

func _physics_process(delta):
	var collider = move_and_collide(currentVelocity)
	
	if collider:
		queue_free()

func _on_timer_timeout():
	queue_free()
