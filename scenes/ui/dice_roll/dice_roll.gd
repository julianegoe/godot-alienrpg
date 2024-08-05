class_name DiceRoll extends Control

const DICE_TEXTURE_SIZE = 22
const FAKE_ROLLS = 6
const FRAME_DELAY = 0.1
const RESULT_DISPLAY_TIME = 2.0

@onready var dice_texture_rect_1 = $TextureRect/HBoxContainer/Dice1
@onready var dice_texture_rect_2 = $TextureRect/HBoxContainer/Dice2
@onready var roll_label = $TextureRect/RollLabel
@onready var target_label = $TextureRect/TargetLabel

func animate_dice_roll(dice_1: int, dice_2: int, target: int) -> void:
	target_label.text = "You need > " + str(target)
	
	var dice_texture_1 = dice_texture_rect_1.texture as AtlasTexture
	var dice_texture_2 = dice_texture_rect_2.texture as AtlasTexture
	
	await _async_roll_animation(dice_texture_1, dice_texture_2)
	
	_set_dice_frame(dice_texture_1, dice_1 - 1)
	_set_dice_frame(dice_texture_2, dice_2 - 1)
	
	roll_label.text = str(dice_1 + dice_2)
	await get_tree().create_timer(RESULT_DISPLAY_TIME).timeout
	roll_label.text = ""

func _async_roll_animation(dice_texture_1: AtlasTexture, dice_texture_2: AtlasTexture) -> void:
	for round in range(FAKE_ROLLS):
		await get_tree().create_timer(FRAME_DELAY).timeout
		_set_random_dice_frame(dice_texture_1)
		_set_random_dice_frame(dice_texture_2)

func _set_random_dice_frame(dice_texture: AtlasTexture) -> void:
	var frame = randi_range(0, 5)
	dice_texture.region.position = Vector2(DICE_TEXTURE_SIZE * frame, 0)

func _set_dice_frame(dice_texture: AtlasTexture, frame: int) -> void:
	dice_texture.region.position.x = DICE_TEXTURE_SIZE * frame
