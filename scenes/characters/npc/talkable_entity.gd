class_name TalkableEntity extends Area2D

signal approached
signal talked_to
signal removed

enum { ENTITY = 32, CHARACTERS = 128 }

@export var speechbubble: Speechbubble
@export var choices_box: ChoicesBox

var is_in_vicinity: bool = false

@onready var state: GameStateResource = preload("res://resources/game_state/collectable_state.tres")

func _ready():
	set_collision_layer(ENTITY)
	set_collision_mask(CHARACTERS)
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)
	self.input_event.connect(_on_input_event)
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	speechbubble.choices_prompted.connect(_on_speechbubble_choices_prompted)
	speechbubble.dialogue_ended.connect(_on_speechbubble_dialogue_ended)

func _unhandled_input(event):
	if event.is_action_pressed("skip") and speechbubble.is_active:
			speechbubble.speed_up_text()
			
func _on_body_entered(_body):
	is_in_vicinity = true
	approached.emit()
	
func _on_body_exited(_body):
	is_in_vicinity = false
	choices_box.hide()
	speechbubble.deactivate()
	removed.emit()
	for choice_button in choices_box.choices_container.get_children():
		choice_button.queue_free()

func _on_input_event(_viewport, event: InputEvent, _shape_idx):
	if is_in_vicinity:
		if event.is_action_pressed("interact"):
			var start_node = speechbubble.dialogue_resource.start_node
			talked_to.emit()
			speechbubble.activate(start_node)
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)

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
		success = await DiceRoll.execute(choice.dice_roll)
		if success:
			choice.success.emit(choice)
		else:
			choice.failure.emit(choice)
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
		
func _on_mouse_entered():
	if is_in_vicinity:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
