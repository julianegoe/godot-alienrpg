extends CanvasLayer

const DICE_TEXTURE_SIZE = 22
const FAKE_ROLLS = 6
const FRAME_DELAY = 0.1
const RESULT_DISPLAY_TIME = 2.0

@export_range(6, 100, 1) var dice_sides_1: int = 6
@export_range(6, 100, 1) var dice_sides_2: int = 6

@onready var dice_texture_rect_1 = $DiceRoll/TextureRect/HBoxContainer/Dice1
@onready var dice_texture_rect_2 = $DiceRoll/TextureRect/HBoxContainer/Dice2
@onready var roll_label = $DiceRoll/TextureRect/RollLabel
@onready var target_label = $DiceRoll/TextureRect/TargetLabel

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
	show()
	get_tree().paused = true
	var difficulty = dice_roll.calculate_difficulty()
	var roll = roll_dice()
	await animate_dice_roll(roll.one, roll.two, difficulty)
	hide()
	get_tree().paused = false
	if roll.sum >= difficulty:
		return true
	return false

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
	for dice_round in range(FAKE_ROLLS):
		await get_tree().create_timer(FRAME_DELAY).timeout
		_set_random_dice_frame(dice_texture_1)
		_set_random_dice_frame(dice_texture_2)

func _set_random_dice_frame(dice_texture: AtlasTexture) -> void:
	var frame = randi_range(0, 5)
	dice_texture.region.position = Vector2(DICE_TEXTURE_SIZE * frame, 0)

func _set_dice_frame(dice_texture: AtlasTexture, frame: int) -> void:
	dice_texture.region.position.x = DICE_TEXTURE_SIZE * frame
