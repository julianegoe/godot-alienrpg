class_name PromptResource extends Resource

signal start_node_updated(index: int)

@export var text: String
@export var choices: Array[ChoiceResource]:
	set(value):
		choices = value
		for choice in choices:
			choice.success.connect(_on_choice_success)
			choice.failure.connect(_on_choice_failure)
@export var next_node: int

func _on_choice_success(choice: ChoiceResource):
	start_node_updated.emit(choice.next_node.success)
	
func _on_choice_failure(choice: ChoiceResource):
	if choice.dice_roll.one_shot:
		start_node_updated.emit(choice.next_node.failure)
