extends Node2D


func _on_area_2d_mouse_entered():
	var tween = create_tween()
	tween.tween_property(self, "position:y", 0, 0.2)

func _on_area_2d_mouse_exited():
	var tween = create_tween()
	tween.tween_property(self, "position:y", 20, 0.2)
