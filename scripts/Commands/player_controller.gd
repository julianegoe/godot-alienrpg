class_name PlayerController
extends Node2D

var player: Player

func _init(character: Player) -> void:
	self.player = character
