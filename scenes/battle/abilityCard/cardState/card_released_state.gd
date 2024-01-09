class_name CardReleasedState extends CardState

var played: bool

func enter() -> void:
	ability_card.color.color = Color.LIGHT_PINK
	ability_card.label.text = ability_card.resource.name
	played = false
	if not ability_card.targets.is_empty():
		played = true
		print(ability_card.targets)
		
func exit() -> void:
	pass

func on_input(event: InputEvent):
	if played:
		return
	else:
		transition_requested.emit(self, CardState.State.BASE)
