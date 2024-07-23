class_name TetheredEnemeies extends Node

@export var tethered_enemies: Array[Node]

func _ready():
	if not tethered_enemies.is_empty():
		for enemy in tethered_enemies:
			if enemy.has_signal("has_died"):
				enemy.has_died.connect(_on_tethered_enemy_has_died)

func _on_tethered_enemy_has_died(enemy: Node):
	var index = tethered_enemies.find(enemy)
	tethered_enemies.remove_at(index)
	if tethered_enemies.is_empty():
		owner.queue_free()
