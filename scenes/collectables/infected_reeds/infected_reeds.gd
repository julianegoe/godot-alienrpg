class_name InfectedReeds extends Sprite2D

@onready var sparkle_notification = $CanvasLayer/SparkleNotification

func _on_collectable_item_collected():
	queue_free()


func _on_collectable_item_player_entered():
	sparkle_notification.show()
	sparkle_notification.play("sparkle_medium")
	
func _on_collectable_item_player_exited():
	sparkle_notification.stop()
	sparkle_notification.hide()
