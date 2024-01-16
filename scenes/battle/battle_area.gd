class_name BattleArea extends Node2D

signal combat_started()
signal combat_ended()

@onready var cards_container: HBoxContainer = $UI/Hand/CardContainer
@onready var hand: MarginContainer = $UI/Hand

@onready var rect_pos: Vector2 = hand.global_position:
	set(value):
		hand.global_position = value
		rect_pos = value
	get:
		return rect_pos

func _on_drop_area_body_entered(body):
	combat_started.emit()

func _on_drop_area_body_exited(body):
	combat_ended.emit()
