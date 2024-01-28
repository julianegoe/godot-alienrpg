class_name CardPlayedState extends CardState

var played: bool

func enter() -> void:
	ability_card.played.emit(ability_card)
	ability_card.queue_free()
		
func exit() -> void:
	pass

func on_texture_button_pressed():
	pass
