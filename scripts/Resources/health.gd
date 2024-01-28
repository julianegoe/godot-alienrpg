class_name HealthResource extends Resource

signal health_changed(value: int)

@export var health: int = 100:
	set(value):
		health = clamp(value, 0, 100)
		health_changed.emit(health)
	get:
		return health
