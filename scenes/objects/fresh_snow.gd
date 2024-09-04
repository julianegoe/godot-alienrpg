class_name FreshSnow extends Sprite2D

@onready var sparkle_notification = $CanvasLayer/SparkleNotification

func _on_collectable_item_collected():
	pass # Replace with function body.


func _on_collectable_item_player_entered():
	sparkle_notification.show()
	sparkle_notification.play("sparkle_medium")


func _on_collectable_item_player_exited():
	sparkle_notification.stop()
	sparkle_notification.hide()
