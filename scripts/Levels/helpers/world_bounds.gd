extends Area2D

@onready var bound_nodes = self.get_children()

enum WorldBound { NORTH, EAST, SOUTH, WEST }

@export var bounds: Array[WorldBound]:
	set(value):
		bounds.append(value)
		for bound in bounds:
			bound_nodes[bound].set_deferred("disabled", false)
	get:
		return bounds
