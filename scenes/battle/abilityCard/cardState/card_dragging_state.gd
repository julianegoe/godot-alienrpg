class_name CardDraggingState extends CardState


func enter() -> void:
	if ability_card.is_node_ready():
		await ability_card.ready
	ability_card.color.color = Color.CADET_BLUE
	ability_card.label.text = "DRAGGING"
	ability_card.reparent_requested.emit(ability_card)
	
func exit() -> void:
	pass
