class_name CardPlayedState extends CardState

var played: bool

func enter() -> void:
	ability_card.played.emit(ability_card)
		
func exit() -> void:
	pass
