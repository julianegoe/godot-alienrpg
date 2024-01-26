class_name CardClickedState extends CardState

func enter() -> void:
	ability_card.activated.emit(ability_card)
	
func exit() -> void:
	pass

func on_texture_button_pressed():
	pass
