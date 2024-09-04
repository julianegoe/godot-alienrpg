class_name QuestDisplay extends Control

@onready var quest_label_scene = preload("res://scenes/ui/inventory/labels/quest_label.tscn")
@onready var resource = preload("res://resources/quests/quests_backlog.tres")
@onready var main_quest_list = $MarginContainer/ScrollContainer/VBoxContainer/MainQuestList

var quest_labels = []
var active_quests: Array[QuestResource]
var unlocked_tasks: Array[TaskResource]

func _ready():
	active_quests = resource.filter_quests_by([QuestResource.QuestStatus.ACTIVE, QuestResource.QuestStatus.FINISHED])
	for quest in active_quests:
		quest.finished.connect(_on_quest_finished)
		for task in quest.tasks:
			task.finished.connect(_on_task_finished)
	update_quests()
		
func update_quests():
	for label in quest_labels:
		label.queue_free()
		quest_labels.clear()
	for quest in active_quests:
		var quest_label: RichTextLabel = quest_label_scene.instantiate()
		quest_labels.append(quest_label)
		quest_label.push_list(0, RichTextLabel.LIST_DOTS, true)
		if quest.status == QuestResource.QuestStatus.FINISHED:
			quest_label.push_strikethrough()
			quest_label.append_text(quest.name)
			quest_label.pop()
		else:
			quest_label.append_text(quest.name)
		quest_label.push_list(1, RichTextLabel.LIST_DOTS, true)
		for task in quest.tasks:
			if task.status == TaskResource.TaskStatus.FINISHED:
				quest_label.push_strikethrough()
				quest_label.append_text(task.description)
				quest_label.pop()
			elif task.status == TaskResource.TaskStatus.LOCKED:
				continue
			else:
				quest_label.append_text(task.description)
			quest_label.newline()
		quest_label.pop()
		quest_label.pop()
		main_quest_list.add_child(quest_label)

func _on_quest_finished(_id):
	update_quests()

func _on_task_finished(_id):
	update_quests()
	
