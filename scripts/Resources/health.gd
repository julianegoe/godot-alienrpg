class_name HealthResource extends Resource

@export var health: int = 100:
	set(value):
		health = clamp(value, 0, 100)
	get:
		return health
