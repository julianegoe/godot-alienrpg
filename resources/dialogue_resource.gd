extends Resource
class_name DialogueResource

@export var name: String = ""
@export var dialogue_tree: Dictionary
@export var display_name: String = ""
@export var dialogue_path: String = ""

func readJSON():
	var file = FileAccess.open(dialogue_path, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	var data = json.parse_string(content)
	dialogue_tree = data
	display_name = data.name
