class_name PlayerTalkState extends PlayerState

var currentVelocity : Vector2 = Vector2.ZERO
var inputDir: Vector2
var SPEECHBUBBLE_OFFSET = Vector2(-58, -66)

func enter():
	player.debug_label.text = "TALK"
	set_talk(true)

func exit():
	set_talk(false)
	
func on_input(event):
	if event.is_action_pressed("skip") and player.speechbubble.is_activated:
		player.speechbubble.skip_text()
	if event.is_action_pressed("interact") and !!player.items.get_equipped():
		transition_requested.emit(self, PlayerState.State.CHARGE)

func on_status_zero(_type: Types.Status):
	transition_requested.emit(self, PlayerState.State.EXHAUSTED)
	
func physics_update(_delta)-> void:
	inputDir = Vector2.ZERO
	#INPUTS
	inputDir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	inputDir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	inputDir = inputDir.normalized()
	currentVelocity = inputDir * 1.5
	if inputDir == Vector2.ZERO:
		transition_requested.emit(self, State.IDLE)
	else:
		update_blend_position(inputDir)
	player.move_and_collide(currentVelocity)
	player.remote_transform_speechbuble.global_position = player.global_position + SPEECHBUBBLE_OFFSET
	
func set_talk(value: bool):
	player.animation_tree["parameters/conditions/idle"] = value

func update_blend_position(direction: Vector2):
	player.animation_tree["parameters/walk/blend_position"] = direction
	player.animation_tree["parameters/idle/blend_position"] = direction
