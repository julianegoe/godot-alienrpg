class_name ChoiceResource extends Resource

signal success(choice: ChoiceResource)
signal failure(choice: ChoiceResource)

@export_enum("Dialogue", "Action") var type: String = "Dialogue"
@export var id: String
@export var text: String
@export var next_node: NextNodeResource
@export var dice_roll: DiceRollResource
