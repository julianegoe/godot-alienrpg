class_name EnemyStartledState extends EnemyState

func enter():
	print("STARTLED")
	enemy.startled()
	enemy.player.camera.apply_shake(1.5, 9.0)

func exit():
	pass

func on_startle_timer_timeout():
	transition_requested.emit(self, EnemyState.State.PURSUIT)
