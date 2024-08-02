class_name PromptResource extends Resource

@export var text: String
@export var choices: Array[ChoiceResource]
@export var next_node: int

func delete_choice(index: int):
	choices.remove_at(index)
