class_name DiceRollResource extends Resource
 
## The Player skill value this test is based on.
@export var skill: Types.Skills
## A value between 0 and 12 to determine the base difficulty of the skill test.
## The higher the number the harder the test will be.
@export_range(0, 12, 1) var difficulty
## will make the test not be repeatable regardless of the outcome.
@export var one_shot: bool = false

var player_stats = preload("res://resources/player_resource.tres")

func calculate_probability():
	var target = difficulty - player_stats.get_skill_value(skill) / 10
	if target < 2:
		return 100.0
	elif target >= 12:
		return 0.0
	
	var total_outcomes: float = 36
	var successful_outcomes: float = 0
	
	for i in range(1, 7):
		for j in range(1, 7):
			if i + j >= target:
				successful_outcomes += 1
	var probability: float = (successful_outcomes / total_outcomes) * 100
	return snapped(probability, 0)

func calculate_difficulty():
	return difficulty - player_stats.get_skill_value(skill) / 10

