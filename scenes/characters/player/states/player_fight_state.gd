class_name PlayerFightState extends PlayerState

var is_fighting: bool

func enter():
	is_fighting = true
	player.health_ui.show()
	player.animation_player.stop()

func on_battle_finished():
	transition_requested.emit(self, PlayerState.State.WALK)

func on_status_zero(_type: Types.Status):
	transition_requested.emit(self, PlayerState.State.EXHAUSTED)
	
