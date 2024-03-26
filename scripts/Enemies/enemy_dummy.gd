class_name AlienFlower extends CharacterBody2D

func _on_danger_zone_body_entered(body):
	if body is Player:
		Events.status_changed.emit(Types.Status.HEALTH, -10)


func _on_hit_box_input_event(viewport, event, _shape_idx):
	if event.is_action_pressed("interact"):
		print("attack")
		viewport.set_input_as_handled()
