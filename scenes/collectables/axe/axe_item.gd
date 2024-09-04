class_name AxeItem extends Sprite2D

@onready var sparkle_notification: AnimatedSprite2D = $CanvasLayer/SparkleNotification

func _on_collectable_item_collected():
	queue_free()

func _on_collectable_item_player_entered() -> void:
	sparkle_notification.show()
	sparkle_notification.play("sparkle_medium")


func _on_collectable_item_player_exited() -> void:
	sparkle_notification.stop()
	sparkle_notification.hide()
