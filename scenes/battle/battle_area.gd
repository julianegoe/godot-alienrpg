class_name BattleArea extends Node2D

@onready var cards_container: HBoxContainer = $UI/Hand/CardContainer
@onready var hand: MarginContainer = $UI/Hand

@onready var rect_pos: Vector2 = hand.global_position:
	set(value):
		hand.global_position = value
		rect_pos = value
	get:
		return rect_pos

	
