class_name StatusManager extends CanvasLayer

@export var status: StatusResource

@onready var health_bar = $Control/MarginContainer/VBoxContainer/HealthBar
@onready var energy_bar = $Control/MarginContainer/VBoxContainer/EnergyBar

func _ready():
	Events.status_changed.connect(_on_status_changed)
	health_bar.value = status.health
	energy_bar.value = status.energy

func _on_status_changed(type: Types.Status, value: int):
	var tween = create_tween()
	match type:
		Types.Status.HEALTH:
			status.health += value
			tween.tween_property(health_bar, "value", status.health, 0.25)
		Types.Status.ENERGY:
			status.energy += value
			tween.tween_property(energy_bar, "value", status.energy, 0.25)

func _on_health_bar_value_changed(value):
	if value == 0:
		Events.status_zero.emit(Types.Status.HEALTH)

func _on_energy_bar_value_changed(value):
	if value == 0:
		Events.status_zero.emit(Types.Status.ENERGY)
