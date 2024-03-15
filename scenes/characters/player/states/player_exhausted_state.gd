class_name PlayerExhaustedState extends PlayerState

func enter():
	print("EXHAUSED")

func exit():
	pass

func on_input(_event):
	transition_requested.emit(self, PlayerState.State.WALK)
