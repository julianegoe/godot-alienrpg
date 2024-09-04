extends Node

var resource = preload("res://resources/quests/quests_backlog.tres")

func _ready():
	for quest in resource.backlog:
		quest.finished.connect(_on_quest_finished)
	activate_quest("001")
	
func get_quest(id: String):
	for quest in resource.backlog:
		if quest.id == id:
			return quest
		else:
			continue
	return null
	
func activate_quest(id: String):
	var quest = get_quest(id)
	if quest:
		quest.status = QuestResource.QuestStatus.ACTIVE
	print_rich(quest.name, ": [color=green] activated [/color]")

func finish_quest(id: String):
	var quest = get_quest(id)
	if quest:
		quest.status = QuestResource.QuestStatus.FINISHED

func _on_quest_finished(id: String):
	print_rich(get_quest(id).name, ": [color=green]finished[/color]")
