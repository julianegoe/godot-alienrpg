class_name DialogueResource extends Resource

@export var display_name: String = ""
@export var dialogue: Array[PromptResource]

func delete_prompt(index: int):
	dialogue.remove_at(index)

