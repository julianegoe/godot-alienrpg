extends Node

signal stat_change(skill: int)

var energy: int = clamp(100, 0, 100):
	set(value):
		energy = value
		stat_change.emit(value)

class Skills:
	signal skill_change(skill: int)
	
	var strength: int = clamp(0, 0, 20):
		set(value):
			strength = clamp(value, 0, 20)
			skill_change.emit(value)
	var charisma: int = clamp(0, 0, 20):
		set(value):
			charisma = clamp(value, 0, 20)
			skill_change.emit(value)
	var intelligence: int = clamp(0, 0, 20):
		set(value):
			intelligence = clamp(value, 0, 20)
			skill_change.emit(value)
	var survival: int = clamp(0, 0, 20):
		set(value):
			survival = clamp(value, 0, 20)
			skill_change.emit(value)

var player_skills = Skills.new()

func roll(difficulty: int, skill):
	var skill_value = player_skills[skill]
	var rolled_number = randi_range(1, 20)
	var modified_number = clamp(rolled_number + skill_value, 0, 20)
	if modified_number >= difficulty:
		return true
	else:
		return false


	
