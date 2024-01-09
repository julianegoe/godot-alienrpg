class_name CardHoverState extends CardState


func enter() -> void:
	ability_card.color.color = Color.STEEL_BLUE
	ability_card.label.text = "HOVERED " + ability_card.card_name
	ability_card.drop_point_detector.monitoring = true
	ability_card.drop_point_detector.mouse_entered.connect(_on_mouse_entered)
	ability_card.drop_point_detector.mouse_exited.connect(_on_mouse_exited)
	
func exit() -> void:
	pass
