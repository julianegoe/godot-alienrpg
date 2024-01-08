extends Node2D

@onready var rect = $ColorRect

@onready var rect_pos: Vector2 = rect.position:
	set(value):
		rect.position = value
		rect_pos = value
	get:
		return rect_pos
		
