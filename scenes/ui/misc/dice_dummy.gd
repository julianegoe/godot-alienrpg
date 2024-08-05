class_name DiceDummy extends Control

@onready var roll_1 = $VBoxContainer/Roll1
@onready var roll_2 = $VBoxContainer/Roll2

func animate_dice_roll(dice_1, dice_2):
	var round: int
	while round < 10:
		await get_tree().create_timer(0.1).timeout
		roll_1.text = str(randi_range(1, 6))
		roll_2.text = str(randi_range(1, 6))
		round += 1
	roll_1.text = str(dice_1)
	roll_2.text = str(dice_2)
	await get_tree().create_timer(1.0).timeout
	
