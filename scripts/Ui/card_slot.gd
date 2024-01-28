class_name CardSlot extends TextureButton

signal card_unequipped(ability: AbilityResource, card: CardButton)

@export var slot_resource: SlotResource

var card_texture: Texture:
	set(value):
		texture_normal = value
		card_texture = value
	get:
		return texture_normal

func init():
	disabled = slot_resource.is_disabled
	if slot_resource and slot_resource.ability:
		card_texture = slot_resource.ability.texture

func _on_pressed():
	card_unequipped.emit(slot_resource.ability, self)
