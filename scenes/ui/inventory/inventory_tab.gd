@tool
class_name InventoryTab extends TextureButton

signal tab_selected(tab: InventoryTab)

@export var type: ItemResource.ItemType
@export var tab_texture: Texture:
	set(value):
		tab_texture = value
		texture_normal = value
		
@export var is_selected: bool = false:
	set(value):
		is_selected = value
		if not is_selected:
			self_modulate = self_modulate.darkened(0.4)
		else:
			self_modulate = Color.WHITE

func _on_pressed():
	tab_selected.emit(self)
