class_name NpcShopkeeper extends Npc

@onready var speechbubble = $UI/PosHelper/Speechbubble
@onready var collision_shape_2d = $Vicinity/CollisionShape2D
@onready var choices_box = $ChoicesUi/Control/Choices

func _ready():
	$AnimationPlayer.play("idle")
	interaction_icon.hide()

func _unhandled_input(event):
	if event.is_action_pressed("skip") and speechbubble.is_active:
			speechbubble.speed_up_text()
						
func _on_player_entered(_body):
	pass

func _on_player_exited(_body):
	choices_box.hide()
	speechbubble.deactivate()
	for choice_button in choices_box.choices_container.get_children():
		choice_button.queue_free()

func _on_vicinity_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("interact") and not speechbubble.is_active and interaction_state == DistanceState.IN_VICINITY:
		speechbubble.activate()
		interaction_icon.hide()

func _create_choices_buttons(choices):
	var prob: String
	for choice in choices:
		if !!choice.dice_roll:
			prob = str(choice.dice_roll.calculate_probability()) + "%"
		else:
			prob = ""
		var button_scene = load("res://scenes/ui/dialogue/choice_button.tscn")
		var button = button_scene.instantiate()
		button.text = choice.text + " " + prob
		button.pressed.connect(_on_choice_selected.bind(choice))
		choices_box.choices_container.add_child(button)

func _on_choice_selected(choice):
	var success: bool = true
	if choice.dice_roll:
		success = await owner.skill_checker.execute(choice.dice_roll)
	if choice.next_node and success:
		speechbubble.activate(choice.next_node.success)
	elif choice.next_node and not success:
		speechbubble.activate(choice.next_node.failure)
	else:
		choices_box.hide()
		speechbubble.deactivate()
	for choice_button in choices_box.choices_container.get_children():
		choice_button.queue_free()

func _on_speechbubble_choices_prompted(choices):
	_create_choices_buttons(choices)
	choices_box.show()

func _on_speechbubble_dialogue_ended():
	choices_box.hide()
	for choice_button in choices_box.choices_container.get_children():
		choice_button.queue_free()
