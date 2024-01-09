extends CanvasLayer

@onready var cards_container: MarginContainer = $CardContainer

@onready var rect_pos: Vector2 = cards_container.position:
	set(value):
		cards_container.position = value
		rect_pos = value
	get:
		return rect_pos
		
