class_name QuestLog extends Control

@onready var center_container = $CenterContainer
@onready var hover_area = $HoverArea

	
func _on_area_2d_mouse_entered():
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(center_container, "rotation", deg_to_rad(-5), 0.25)
	tween.tween_property(center_container, "position:x", -20, 0.25)


func _on_area_2d_mouse_exited():
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(center_container, "rotation", deg_to_rad(0), 0.25)
	tween.tween_property(center_container, "position:x", 0, 0.25)


func _on_container_mouse_entered():
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(center_container, "rotation", deg_to_rad(-5), 0.25)
	tween.tween_property(center_container, "position:x", -20, 0.25)
	hover_area.hide()


func _on_texture_button_pressed():
	center_container.position.x = 0
	center_container.rotation = deg_to_rad(0)
	center_container.set_anchors_and_offsets_preset(Control.PRESET_CENTER_RIGHT, Control.PRESET_MODE_KEEP_SIZE, 5)


func _on_center_container_mouse_exited():
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(center_container, "rotation", deg_to_rad(0), 0.25)
	await tween.tween_property(center_container, "position:x", 0, 0.25).finished
	center_container.set_anchors_and_offsets_preset(Control.PRESET_CENTER_LEFT, Control.PRESET_MODE_KEEP_SIZE, 0)
	hover_area.show()
