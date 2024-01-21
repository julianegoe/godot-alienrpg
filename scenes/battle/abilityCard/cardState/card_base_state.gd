class_name CardBaseState extends CardState


func enter() -> void:
	print("base")

func exit() -> void:
	pass

func on_texture_button_pressed():
	print("clicked ", ability_card.card_resource.name)
	transition_requested.emit(self, CardState.State.CLICKED)
	
func on_mouse_entered():
	var tween = create_tween()
	tween.tween_property(ability_card, "position:y", -10, 0.2)

func on_mouse_exited():
	var tween = create_tween()
	tween.tween_property(ability_card, "position:y", 0, 0.2)
