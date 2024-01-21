class_name SkillChecker extends Node

signal skill_check_effect(effects)

func perform_skill_check(type, attacker_skill, attacker_ability, opponent_defense):
	var attacker_modifier = attacker_skill + attacker_ability.modifier
	var oponent_modifier = opponent_defense
	var attacker_roll = _roll(attacker_modifier)
	var oponent_roll = _roll(oponent_modifier)
	if attacker_roll >= oponent_roll:
		skill_check_effect.emit(attacker_ability.effects)
	elif oponent_roll >= attacker_roll:
		return
	
		
func _roll(modifier: int):
	var rolled_number = randi_range(1, 20)
	return clamp(rolled_number + modifier, 0, 20)
