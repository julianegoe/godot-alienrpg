extends Node

func roll(modifier: int):
	var rolled_number = randi_range(1, 20)
	return clamp(rolled_number + modifier, 0, 20)
