class_name ItemIdleState extends ItemState

var drag_direction

func enter() -> void:
	item.selector.position = Vector2(-2, -2)
	item.item_icon.self_modulate.a = 1
	
func exit() -> void:
	pass

func on_button_down():
	if item.disabled == false:
		transition_requested.emit(self, ItemState.State.DRAGGING)
