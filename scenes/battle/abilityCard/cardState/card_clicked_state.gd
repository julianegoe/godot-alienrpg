class_name CardClickedState extends CardState


func enter() -> void:
	ability_card.color.color = Color.LIGHT_CORAL
	ability_card.label.text = ability_card.resource.name
	ability_card.drop_point_detector.monitoring = true
	
func exit() -> void:
	pass

func on_input(event: InputEvent):
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGING) 
