class_name CardBaseState extends CardState


func enter() -> void:
	ability_card.reparent_requested.emit(ability_card)
	ability_card.color.color = Color.SEA_GREEN
	ability_card.label.text = "BASE " + ability_card.card_name
	ability_card.pivot_offset = Vector2.ZERO
	
func exit() -> void:
	pass

func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		ability_card.pivot_offset = ability_card.get_global_mouse_position() - ability_card.global_position
		transition_requested.emit(self, CardState.State.CLICKED)

func on_mouse_enter():
	var tween = create_tween()
	tween.tween_property(ability_card, "position:y", -10, 0.2)

func on_mouse_exit():
	var tween = create_tween()
	tween.tween_property(ability_card, "position:y", 0, 0.2)
