class_name SkillChecker extends Node

@export var dice_ui: DiceRoll
@export_range(6, 100, 1) var dice_sides_1: int = 6
@export_range(6, 100, 1) var dice_sides_2: int = 6

var roll_1: int
var roll_2: int 
@onready var rng = RandomNumberGenerator.new()

func roll_dice():
	roll_1 = rng.randi_range(1, dice_sides_1)
	roll_2 = rng.randi_range(1, dice_sides_2)
	return {
		"one": roll_1,
		"two": roll_2,
		"sum": roll_1 + roll_2
	}
	
func execute(dice_roll: DiceRollResource):
	dice_ui.show()
	var difficulty = dice_roll.calculate_difficulty()
	var roll = roll_dice()
	await dice_ui.animate_dice_roll(roll.one, roll.two, difficulty)
	dice_ui.hide()
	if roll.sum >= difficulty:
		return true
	return false
