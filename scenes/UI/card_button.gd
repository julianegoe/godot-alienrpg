class_name CardButton extends TextureButton

signal card_equipped(ability: AbilityResource, card: CardButton)

@export var card_resource: CardResource

var card_texture: Texture:
	set(value):
		card_texture = value
		self.texture_normal = value
	get:
		return card_texture
		
var card_texture_hovered: Texture:
	set(value):
		card_texture_hovered = value
		self.texture_hover = value
	get:
		return card_texture
 
func init():
	if card_resource and card_resource.ability:
		card_texture = card_resource.ability.texture
		card_texture_hovered = card_resource.ability.texture_hovered
		self.disabled = card_resource.is_disabled

func _on_pressed():
	card_equipped.emit(card_resource.ability, self)
