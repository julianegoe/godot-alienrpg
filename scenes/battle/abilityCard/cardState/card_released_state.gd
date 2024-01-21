class_name CardPlayedState extends CardState

var played: bool

func enter() -> void:
	played = false
		
func exit() -> void:
	pass

func on_input(_event: InputEvent):
	if played:
		return
	else:
		transition_requested.emit(self, CardState.State.BASE)
