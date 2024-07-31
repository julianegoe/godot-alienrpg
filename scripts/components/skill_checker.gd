class_name SkillChecker extends Node

@export_range(6, 100, 1) var dice_sides: int = 6

@onready var rng = RandomNumberGenerator.new()

func roll_dice():
	var roll = rng.randi_range(1, dice_sides)
	return roll
	
func execute(skill: GameTypes.Skills, difficulty: Variant):
	var skill_value = owner.player.stats.get_skill_value(skill)
	var roll = roll_dice()
	if roll < difficulty + skill_value:
		return true
	return false
