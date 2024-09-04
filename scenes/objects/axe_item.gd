class_name AxeItem extends Sprite2D


func _on_collectable_item_collected():
	queue_free()
