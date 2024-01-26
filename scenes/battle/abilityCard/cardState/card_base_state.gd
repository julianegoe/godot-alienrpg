class_name CardBaseState extends CardState


func enter() -> void:
	pass

func exit() -> void:
	pass

func on_texture_button_pressed():
	print("clicked ", ability_card.ability.name)
	if ability_card.ability.uses == -1:
		transition_requested.emit(self, CardState.State.CLICKED)
	else:
		transition_requested.emit(self, CardState.State.PLAYED)
	
func on_mouse_entered():
	var tween = create_tween()
	tween.tween_property(ability_card, "position:y", -10, 0.2)

func on_mouse_exited():
	var tween = create_tween()
	tween.tween_property(ability_card, "position:y", 0, 0.2)
