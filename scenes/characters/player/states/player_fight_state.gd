class_name PlayerFightState extends PlayerState

var currentVelocity : Vector2 = Vector2.ZERO
var inputDir: Vector2
var SPEECHBUBBLE_OFFSET = Vector2(-58, -66)

func enter():
	print("ATTACK")
	player.animation_player.play("attack_front")

func on_status_zero(_type: Types.Status):
	transition_requested.emit(self, PlayerState.State.EXHAUSTED)

func on_input(_event: InputEvent):
	transition_requested.emit(self, PlayerState.State.WALK)
