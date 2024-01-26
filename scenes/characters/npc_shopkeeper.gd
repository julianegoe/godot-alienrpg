class_name npc_shopkeeper extends Npc

@onready var speechbubble: Speechbubble = $UI/PosHelper/Speechbubble

func _ready():
	$AnimationPlayer.play("idle")
	interaction_icon.hide()

func _unhandled_key_input(event):
	if event.is_action_pressed("skip") and speechbubble.ui_state == speechbubble.UiState.OPEN:
			speechbubble.skip_text()
	if event.is_action_pressed("interact") and speechbubble.ui_state == speechbubble.UiState.CLOSED and interaction_state == DistanceState.IN_VICINITY:
		speechbubble.activate()
		interaction_icon.hide()
	get_viewport().set_input_as_handled()
				
func _on_player_entered(_body):
	pass

func _on_player_exited(_body):
	speechbubble.deactivate()
