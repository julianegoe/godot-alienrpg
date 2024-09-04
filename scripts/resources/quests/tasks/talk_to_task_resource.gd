class_name TalkToResource extends TaskResource

@export var dialogue: DialogueResource:
	set(value):
		dialogue = value

@export var selected_choice: ChoiceResource:
	set(value):
		selected_choice = value
		selected_choice.success.connect(_on_choice_success)

func _on_choice_success(_choice: ChoiceResource):
	status = TaskStatus.FINISHED
