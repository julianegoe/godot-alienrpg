class_name EnemyAttackState extends EnemyState

var can_attack: bool = false

func enter():
	print("ATTACK")
	can_attack = true

func exit():
	can_attack = false

func on_attack_finished():
	can_attack = true

func on_defeated():
	transition_requested.emit(self, EnemyState.State.DEFEATED)
	
func on_vicinity_body_exited(body):
	if body is Player:
		transition_requested.emit(self, EnemyState.State.PURSUIT)

func physics_update(_delta):
	if can_attack:
		enemy.attack()
		can_attack = false
