class_name DialogueResource extends Resource

signal started

@export var start_node: int = 0
@export var display_name: String = ""
@export var prompts: Array[PromptResource]:
	set(value):
		prompts = value
		for prompt in prompts:
			prompt.start_node_updated.connect(_on_start_node_updated)

func delete_prompt(index: int):
	prompts.remove_at(index)

func _on_start_node_updated(index: int):
	start_node = index
