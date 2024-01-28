class_name BattleDashboard extends MarginContainer
@onready var card_container = $Hand/CardContainer
@onready var end_turn_button = $EndTurnButton

var disabled = true:
	set(value):
		disabled = value
		if not disabled:
			_enable_dashboard()
		else:
			_disable_dashboard()
	get:
		return disabled
	
func show_dashboard():
	var tween = create_tween()
	tween.tween_property(self, "position:y", 200, 1)

func hide_dashboard():
	var tween = create_tween()
	tween.tween_property(self, "position:y", 270, 1)

func _enable_dashboard():
	end_turn_button.disabled = false
	var abilities = card_container.get_children(false)
	for ability in abilities:
		ability.card.disabled = false

func _disable_dashboard():
	end_turn_button.disabled = true
	var abilities = card_container.get_children(false)
	for ability in abilities:
		ability.card.disabled = true
		
func _ready():
	position.y = 270
