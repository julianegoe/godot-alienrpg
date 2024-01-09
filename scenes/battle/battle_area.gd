extends CanvasLayer

@onready var cards_container: HBoxContainer = $Hand/CardContainer
@onready var hand: MarginContainer = $Hand

@onready var rect_pos: Vector2 = hand.position:
	set(value):
		hand.position = value
		rect_pos = value
	get:
		return rect_pos

	
