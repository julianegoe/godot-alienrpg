class_name CardSlot extends TextureRect

@export var slot_resource: SlotResource

var is_equipped: bool:
	set(value):
		is_equipped = value
		slot_resource.is_equipped = value	
	get:
		return is_equipped

var card_texture: Texture:
	set(value):
		card_texture = value
		if not is_equipped:
			self.texture = value
			#slot_resource.ability.texture = value
			
	get:
		return card_texture

func _ready():
	if slot_resource and slot_resource.ability:
		card_texture = slot_resource.ability.texture
		is_equipped = slot_resource.is_equipped 
