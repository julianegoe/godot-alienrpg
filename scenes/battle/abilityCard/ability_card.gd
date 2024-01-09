class_name AbilityCard extends Control

signal reparent_requested(ability_card: AbilityCard)

@onready var color: ColorRect = $ColorRect
@onready var label: Label = $ColorRect/CenterContainer/Label
@onready var drop_point_detector: Area2D = $DropPointSelector

func _ready():
	$CardStateMachine.init(self)
