class_name PlayerChargeMeleeState extends PlayerState

var charge_indicator: AnimatedSprite2D
var is_about_to_attack: bool = false

func enter():
	player.debug_label.text = "CHARGE MELEE"
	player.melee_attack_strength = 0.0
	charge_indicator = player.charge_indicator
	update_blend_position(get_charge_vector())
	set_charge(true)
	charge_indicator.play()
	
func exit():
	set_charge(false)
	charge_indicator.stop()

func on_input(event: InputEvent):
	if event.is_action_released("interact"):
		is_about_to_attack = true
		transition_requested.emit(self, PlayerState.State.ATTACK_MELEE)
	
func set_charge(value: bool):
	player.animation_tree["parameters/conditions/charge_melee"] = value

func update_blend_position(direction: Vector2):
	player.animation_tree["parameters/charge_melee_buildup/blend_position"] = direction
	player.animation_tree["parameters/charge_melee/blend_position"] = direction
	player.animation_tree["parameters/attack_melee/blend_position"] = direction
	player.animation_tree["parameters/idle/blend_position"] = direction

func get_charge_vector():
	var direction = (player.get_global_mouse_position() - player.global_position).normalized()
	return direction

func on_charge_indicator_animation_finished():
	await get_tree().create_timer(0.25).timeout
	if not is_about_to_attack:
		charge_indicator.pause()
		transition_requested.emit(self, PlayerState.State.IDLE)

func on_health_exhausted():
	transition_requested.emit(self, PlayerState.State.EXHAUSTED)
	
func physics_update(delta):
	player.melee_attack_strength += delta
