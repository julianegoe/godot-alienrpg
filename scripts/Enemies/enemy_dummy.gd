class_name EnemyDummy extends CharacterBody2D

func _on_danger_zone_body_entered(body):
	if body is Player:
		Events.status_changed.emit(Types.Status.HEALTH, -20)
