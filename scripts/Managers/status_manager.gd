class_name StatusManager extends CanvasLayer

@export var status: StatusResource

@onready var health_bar = $Control/MarginContainer/VBoxContainer/HealthBar
@onready var energy_bar = $Control/MarginContainer/VBoxContainer/EnergyBar

func _ready():
	Events.status_changed.connect(_on_status_changed)
	health_bar.value = status.health
	energy_bar.value = status.energy

func _on_status_changed(type: Types.Status, value: int):
	match type:
		Types.Status.HEALTH:
			status.health = value
			health_bar.value = status.health 
		Types.Status.ENERGY:
			status.energy = value
			energy_bar.value = status.energy

