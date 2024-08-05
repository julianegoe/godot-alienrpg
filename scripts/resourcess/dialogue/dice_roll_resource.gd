class_name DiceRollResource extends Resource
 
@export var skill: GameTypes.Skills
@export_range(0, 12, 1) var difficulty

var player_stats = preload("res://resources/player_resource.tres")

func calculate_probability():
	var target = difficulty - player_stats.get_skill_value(skill) / 10
	if target < 2:
		return 0.0
	elif target >= 12:
		return 100.0
	
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

