@tool
class_name InventoryFileCategory extends TextureButton

signal category_selected(category: InventoryFileCategory)

enum FileCategory { DETAILS, STATS }

@export var type: FileCategory

@export var tab_color: Color:
	set(value):
		tab_color = value
		self_modulate = value
		
@export var is_selected: bool = false:
	set(value):
		is_selected = value
		if not is_selected:
			self_modulate = self_modulate.darkened(0.4)
		else:
			self_modulate = tab_color

func _on_pressed():
	category_selected.emit(self)
