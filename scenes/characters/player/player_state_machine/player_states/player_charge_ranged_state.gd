class_name PlayerChargeRangedState extends PlayerState

var charge_indicator: AnimatedSprite2D
var projectile: Projectile
var is_about_to_attack: bool = false

func enter():
	player.debug_label.text = "CHARGE RANGED"
	is_about_to_attack = false
	player.ranged_attack_strength = 0.0
	charge_indicator = player.charge_indicator
	update_blend_position(get_charge_vector())
	set_charge(true)
	projectile = load(player.equipped_item.scene_path).instantiate()
	player.ranged_weapon_spawner.add_child(projectile)
	charge_indicator.play()
	
func exit():
	charge_indicator.stop()
	set_charge(false)

func on_input(event: InputEvent):
	if event.is_action_released("interact"):
		is_about_to_attack = true
		player.weapon_target_position = player.get_global_mouse_position()
		transition_requested.emit(self, PlayerState.State.ATTACK_RANGED)
		
func set_charge(value: bool):
	player.animation_tree["parameters/conditions/charge_ranged"] = value

func update_blend_position(direction: Vector2):
	player.animation_tree["parameters/charge_ranged_buildup/blend_position"] = direction
	player.animation_tree["parameters/charge_ranged/blend_position"] = direction
	player.animation_tree["parameters/attack_ranged/blend_position"] = direction
	player.animation_tree["parameters/idle/blend_position"] = direction

func get_charge_vector():
	var direction = (player.get_global_mouse_position() - player.global_position).normalized()
	return direction

func on_charge_indicator_animation_finished():
	await get_tree().create_timer(0.25).timeout
	if not is_about_to_attack:
		charge_indicator.pause()
		projectile.destroy()
		transition_requested.emit(self, PlayerState.State.IDLE)

func on_health_exhausted():
	transition_requested.emit(self, PlayerState.State.EXHAUSTED)
	
func physics_update(delta):
	player.ranged_attack_strength += delta
