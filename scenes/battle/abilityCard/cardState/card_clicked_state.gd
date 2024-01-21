class_name CardClickedState extends CardState

func enter() -> void:
	print("clicked")
	ability_card.card_activated.emit(ability_card.card_resource)
	
func exit() -> void:
	pass

func on_texture_button_pressed():
	pass
