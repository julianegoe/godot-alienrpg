class_name PlayerFightState extends PlayerState

var is_fighting: bool

func enter():
	is_fighting = true
	player.animation_player.stop()
