class_name  ItemPickupPreviewBar extends Control

@onready var preview_scene
@onready var preview_container = $PreviewContainer


func _ready():
	preview_scene = preload("res://scenes/ui/item_pickup/item_pickup_preview.tscn")
	InventoryManager.item_added.connect(_on_item_added)

func _on_item_added(item: ItemResource):
	var tween = create_tween()
	var preview = preview_scene.instantiate()
	preview_container.add_child(preview)
	preview.modulate.a = 0
	preview.display_name.text = item.display_name
	preview.item_icon.texture = item.icon_texture
	tween.tween_property(preview, "modulate:a", 1, 0.5)

	
