class_name ItemPickupPreview extends BoxContainer

@onready var item_icon = $ItemIcon
@onready var display_name = $PanelContainer/HBoxContainer/DisplayName
@onready var timer = $Timer

func _on_timer_timeout():
	var tween = create_tween()
	await tween.tween_property(self, "modulate:a", 0, 0.75).finished
	queue_free()
