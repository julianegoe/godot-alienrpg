class_name CardAimingState extends CardState

const MOUSE_Y_SNAPBACK_THRESHOLD = 265

func enter() -> void:
	ability_card.color.color = Color.MEDIUM_PURPLE
	ability_card.label.text = ability_card.resource.name
	ability_card.targets.clear()
	var offset = Vector2(ability_card.parent.size.x / 2, -ability_card.size.y)
	ability_card.animate_to_position(ability_card.parent.global_position + offset, 0.2)
	ability_card.drop_point_detector.monitoring = false
	Events.card_aim_started.emit(ability_card)
	
	
func exit() -> void:
	Events.card_aim_ended.emit(ability_card)

func on_input(event: InputEvent):
	var mouse_motion = event is InputEventMouseMotion
	var mouse_at_bottom = ability_card.get_global_mouse_position().y >= MOUSE_Y_SNAPBACK_THRESHOLD
	if (mouse_at_bottom and mouse_motion) or event.is_action_pressed("right_mouse"):
		transition_requested.emit(self, CardState.State.BASE)
	if event.is_action_pressed("left_mouse") or event.is_action_released("left_mouse"):
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
