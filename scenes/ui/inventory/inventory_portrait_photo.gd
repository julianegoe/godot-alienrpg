class_name InventoryPortraitPhoto extends Sprite2D

@onready var photo_label = $PhotoLabel

@export var resource: Resource:
	set(value):
		resource = value
		show()
		texture = resource.portrait_texture
		photo_label.text = resource.display_name

func _ready():
	if resource:
		show()
	else:
		hide()
	
