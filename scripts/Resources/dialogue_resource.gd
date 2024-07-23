class_name DialogueResource extends Resource

@export_file var dialogue_path

var name: String = ""
var dialogue_tree: Dictionary
var display_name: String = ""

func readJSON():
	var file = FileAccess.open(dialogue_path, FileAccess.READ)
	var content = file.get_as_text()
	var data = JSON.parse_string(content)
	dialogue_tree = data
	display_name = data.name
