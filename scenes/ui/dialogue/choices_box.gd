class_name ChoicesBox extends TextureRect

enum Portrait { PLAYER, SHOPKEEPER }

@export var portrait: Portrait

@onready var choices_container = $ChoicesContainer
@onready var texture_rect: TextureRect = $TextureRect
	
func _ready():
	var portrait_texture = texture_rect.texture as AtlasTexture
	match portrait:
		Portrait.PLAYER:
			portrait_texture.region.position = Vector2(0,0)
		Portrait.SHOPKEEPER:
			portrait_texture.region.position = Vector2(50,0)
	
