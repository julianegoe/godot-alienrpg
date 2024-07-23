class_name PlayerAttackRangedState extends PlayerState

const MAX_DAMAGE: int = 500
const MIN_DAMAGE: int = 0
const MAX_STRENGTH = 300
const MIN_STRENGTH = 100
var inputDir: Vector2
var projectile_scene: PackedScene
var projectile: Projectile

func enter():
	player.debug_label.text = "ATTACK RANGED"
	update_blend_position(get_attack_vector())
	set_attack(true)

func exit():
	update_blend_position(get_attack_vector())
	set_attack(false)
	InventoryManager.remove_item(player.equipped_item, 1, ItemResource.QuantityType.HOTBAR)

func on_attack_animation_finished():
	transition_requested.emit(self, PlayerState.State.IDLE)

func on_attack_ranged_start():
	projectile = player.ranged_weapon_spawner.get_child(0)
	projectile.reparent(player.owner, true)
	projectile.shadow.damage = calculate_attack_damage()
	var strength = calculate_attack_strength()
	var vertical_velocity = player.equipped_item.vertical_velocity
	projectile.init(get_attack_vector() * strength, vertical_velocity, player.global_position)
	
func set_attack(value: bool):
	player.animation_tree["parameters/conditions/attack_ranged"] = value

func update_blend_position(direction: Vector2):
	player.animation_tree["parameters/attack_ranged/blend_position"] = direction
	player.animation_tree["parameters/idle/blend_position"] = direction

func on_health_exhausted():
	transition_requested.emit(self, PlayerState.State.EXHAUSTED)
	
func get_attack_vector() -> Vector2:
	var direction = (player.weapon_target_position - player.global_position).normalized()
	return direction

func calculate_attack_strength():
	var player_strength = player.stats.strength
	var throw_modificator = player.ranged_attack_strength
	var strength: float = MAX_STRENGTH * player_strength / 100
	return clamp(strength * throw_modificator, MIN_STRENGTH, MAX_STRENGTH)

func calculate_attack_damage():
	var base_damage = player.equipped_item.base_damage
	var base_strength = player.stats.strength
	var charge_modifier = player.ranged_attack_strength
	var strength_modifier = player.equipped_item.strength_modifier
	var damage = Utils.get_attack_damage_from(base_damage, base_strength, strength_modifier, charge_modifier)
	return clamp(damage, MIN_DAMAGE, MAX_DAMAGE)
