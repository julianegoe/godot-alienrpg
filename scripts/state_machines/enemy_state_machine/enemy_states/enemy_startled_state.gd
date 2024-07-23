class_name EnemyStartledState extends EnemyState

func enter():
	print("STARTLED")
	enemy.startled()

func exit():
	pass

func on_startle_timer_timeout():
	transition_requested.emit(self, EnemyState.State.PURSUIT)
