class_name Enemy extends Npc

signal initiate_fight(enemy)

@onready var healthBar = $Ui/HealtBar

func _unhandled_key_input(event):
	if event.is_action_pressed("interact") and interaction_state == DistanceState.IN_VICINITY:
		interaction_icon.hide()
		initiate_fight.emit(self)
