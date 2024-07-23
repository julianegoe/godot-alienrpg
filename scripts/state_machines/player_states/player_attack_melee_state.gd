class_name PlayerAttackMeleeState extends PlayerState

const MAX_DAMAGE: int = 500
const MIN_DAMAGE: int = 0
var currentVelocity : Vector2 = Vector2.ZERO
var inputDir: Vector2
var SPEECHBUBBLE_OFFSET = Vector2(-58, -66)

func enter():
	player.debug_label.text = "ATTACK MELEE"
	update_blend_position(get_attack_vector())
	set_attack(true)
	calculate_attack_damage()

func exit():
	update_blend_position(get_attack_vector())
	set_attack(false)

func on_attack_animation_finished():
	transition_requested.emit(self, PlayerState.State.IDLE)
	
func set_attack(value: bool):
	player.animation_tree["parameters/conditions/attack_melee"] = value

func update_blend_position(direction: Vector2):
	player.animation_tree["parameters/attack_melee/blend_position"] = direction
	player.animation_tree["parameters/idle/blend_position"] = direction

func get_attack_vector():
	var direction = (player.get_global_mouse_position() - player.global_position).normalized()
	return direction

func on_health_exhausted():
	transition_requested.emit(self, PlayerState.State.EXHAUSTED)
	
func calculate_attack_damage():
	var base_damage = player.equipped_item.base_damage
	var base_strength = player.stats.strength
	var acharge_modifier = player.melee_attack_strength
	var strength_modifier = player.equipped_item.strength_modifier
	var damage = Utils.get_attack_damage_from(base_damage, base_strength, strength_modifier, acharge_modifier)
	player.melee_hit_box.damage = damage
