class_name EnemyPursuitState extends EnemyState

var direction: Vector2
var speed: int

func enter():
	print("PURSUIT")
	speed = enemy.max_speed
	enemy.pursuit()

func exit():
	speed = 0

func on_attack_finished():
	pass
	
func take_damage(_damage):
	transition_requested.emit(self, EnemyState.State.STARTLED)

func on_defeated():
	transition_requested.emit(self, EnemyState.State.DEFEATED)
	
func on_vicinity_body_entered(body):
	if body is Player:
		transition_requested.emit(self, EnemyState.State.ATTACK)
		
func physics_update(_delta):
	if enemy.player:
		direction = enemy.global_position.direction_to(enemy.player.global_position)
		enemy.move_and_slide()
		enemy.velocity = direction * speed
		var cardinal_direction = Utils.get_closest_cardinal_direction(direction)
		enemy.set_animation_for(cardinal_direction)
