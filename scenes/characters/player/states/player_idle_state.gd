class_name PlayerIdleState extends PlayerState

func enter():
	player.label.hide()
	if debug_mode:
		player.label.show()
		player.label.text = "IDLE"
	player.animation_player.play("idle_front")

func exit():
	pass
	
func on_input(event: InputEvent):
	if event.is_pressed():
		transition_requested.emit(self, PlayerState.State.WALK)
		
func physics_update(delta):
	if Input.is_action_just_released("down"):
		player.animation_player.play("idle_front")
	if Input.is_action_just_released("up"):
		player.animation_player.play("idle_back")
	if Input.is_action_just_released("right"):
		player.animation_player.play("idle_right")
	if Input.is_action_just_released("left"):
		player.animation_player.play("idle_left")
		


