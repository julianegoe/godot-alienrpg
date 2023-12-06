extends CanvasLayer

@onready var energy_label = $Control/HBoxContainer/EnergyState

func _ready():
	PlayerStats.connect("stat_change", update_stats)
	update_stats()

func update_stats():
	energy_label.text = str(PlayerStats.energy)
