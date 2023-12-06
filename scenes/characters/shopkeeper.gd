extends CharacterBody2D

@onready var components: Node = $Components
@onready var vicinity: Area2D = $Vicinity
@export var dialogue: DialogueResource

var talk_component: TalkComponent

func _ready():
	dialogue.readJSON()
	talk_component = TalkComponent.new(self)
	components.add_child(talk_component)
	talk_component.dice_roll.connect(_on_dice_roll)

func _on_dice_roll(skillTest):
	if skillTest:
		var success = PlayerStats.roll(skillTest.difficulty, skillTest.skill)
		print(success)
