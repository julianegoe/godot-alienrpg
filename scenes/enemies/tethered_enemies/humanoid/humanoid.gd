class_name Humanoid extends Enemy

signal attack_finished

@export var tethered_enemies: Array[Node]

@onready var max_speed: int = resource.max_speed
@onready var enemy_state_machine = $EnemyStateMachine

@onready var tethered = $Tethered
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var startle_timer = $StartleTimer
@onready var cpu_particles_2d = $CPUParticles2D
@onready var vicinity = $Vicinity
@onready var hit_box = $HitBox
@onready var hit_box_collision_shape = $HitBox/HitBoxCollisionShape

func _ready():
	tethered.init(tethered_enemies)
	hit_box.monitorable = false
	enemy_state_machine.init(self)

func pursuit():
	animated_sprite_2d.stop()
	animated_sprite_2d.modulate.a = 0.9
	vicinity.monitoring = true

func startled():
	vicinity.monitoring = false
	animated_sprite_2d.play("startled")
	animated_sprite_2d.modulate.a = 0.8
	
func attack():
	animated_sprite_2d.play("attack")
	hit_box.monitorable = true
	var tween = get_tree().create_tween()
	#cpu_particles_2d.emitting = true
	await tween.tween_property(hit_box_collision_shape.shape, "radius", 30, 1.5).finished
	hit_box_collision_shape.shape.radius = 1
	hit_box.monitorable = false
	attack_finished.emit()

func take_damage(damage: int):
	enemy_state_machine.take_damage(damage)
	startle_timer.wait_time = resource.get_startle_time(damage)
	startle_timer.start()

func defeated():
	animated_sprite_2d.play("die")
	var tween = create_tween()
	await tween.tween_property(animated_sprite_2d, "modulate:a", 0, 2).finished
	queue_free()
	
func set_animation_for(direction: Vector2):
	if direction == Vector2.RIGHT:
		animated_sprite_2d.play("pursue_left")
		animated_sprite_2d.flip_h = true
	elif direction == Vector2.LEFT:
		animated_sprite_2d.play("pursue_left")
		animated_sprite_2d.flip_h = false
	elif direction == Vector2.UP:
		animated_sprite_2d.play("pursue_back")
	elif direction == Vector2.DOWN:
		animated_sprite_2d.play("pursue_front")
	
func _on_vicinity_body_entered(body):
	enemy_state_machine.on_vicinity_body_entered(body)

func _on_vicinity_body_exited(body):
	enemy_state_machine.on_vicinity_body_exited(body)

func _on_startle_timer_timeout():
	enemy_state_machine.on_startle_timer_timeout()

func _on_attack_finished():
	cpu_particles_2d.emitting = false
	enemy_state_machine.on_attack_finished()

func _physics_process(delta):
	enemy_state_machine.physics_update(delta)

func _on_tethered_freed():
	enemy_state_machine.on_defeated()
