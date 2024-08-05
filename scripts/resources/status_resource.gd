class_name StatusResource extends Resource

# Can be damaged by creature attacks and physical accidents. 
# Replenishs by eating food, taking medicine
@export var health: int = 100:
	set(value):
		health = clamp(value, 0, 100)
	get:
		return health

# depletes in the course of 24h if not replenished by sleeping, coffee etc.
@export var energy: int = 100:
	set(value):
		energy = clamp(value, 0, 100)
	get:
		return energy

# EXPERIMENTAL
# depletes over time if not worked on the assignment. 
# Replenished when working on assignment.
# will have different effects when low or high dutifulness.
@export var EXPERIMENTAL_dutifulness: int = 100:
	set(value):
		EXPERIMENTAL_dutifulness = clamp(value, 0, 100)
	get:
		return EXPERIMENTAL_dutifulness
