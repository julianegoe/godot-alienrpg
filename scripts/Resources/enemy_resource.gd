class_name EnemyResource extends Resource

enum AttackType { PHYSICAL, METAPHYSICAL, ALCHEMICAL }
enum EnemyType { TETHERED, PHYSICAL, METAPHYSICAL }

@export var type: EnemyType
@export var max_speed: int
@export var max_health: int
@export var health: int:
	set(value):
		health = clamp(value, 0, max_health)
@export var immunity: Array[AttackType]
@export var startle_time = {
	"low": 0.0,
	"medium": 0.0,
	"high": 0.0,
	"default": 0.0,
}
func get_startle_time(damage: int):
	if damage <= 100:
		return startle_time.low
	elif damage <= 102:
		return startle_time.medium
	elif damage <= 105:
		return startle_time.high
	else:
		return startle_time.default
