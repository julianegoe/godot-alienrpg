class_name CardDraggingState extends CardState
const DRAG_MINIMUM_THRESHOLD: int = 0.05
var minimum_drag_time_elapsed: bool = false

func enter() -> void:
	#var ui_layer = get_tree().get_first_node_in_group("Battle_UI")
	#if ui_layer:
		#ability_card.reparent(ui_layer)
	ability_card.color.color = Color.CADET_BLUE
	ability_card.label.text = ability_card.resource.name
	
	minimum_drag_time_elapsed = false
	var threshold_timer = get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)
	
func exit() -> void:
	pass

func on_input(event: InputEvent) -> void:
	var is_single_targeted: bool = ability_card.resource.is_single_targeted()
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	if is_single_targeted and ability_card.targets.size() > 0 and mouse_motion:
		transition_requested.emit(self, CardState.State.AIMING)
		return
	if mouse_motion:
		ability_card.global_position = ability_card.get_global_mouse_position() - ability_card.pivot_offset
	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	elif confirm and minimum_drag_time_elapsed:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)

	
