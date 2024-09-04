class_name QuestResource extends Resource

signal finished(id: String)

enum QuestStatus { LOCKED, ACTIVE, FINISHED }
@export var id: String
@export var name: String
@export var description: Array[String]
@export var status: QuestStatus
@export var is_hidden: bool = false
@export var tasks: Array[TaskResource]:
	set(value):
		tasks = value
		for task in tasks:
			task.finished.connect(_on_task_finished, CONNECT_ONE_SHOT)

func get_task(target_id: String):
	for task in tasks:
		if task.id == target_id:
			return task
		else:
			continue
	return null
	
func _on_task_finished(finished_id):
	print_rich(get_task(finished_id).name, ": [color=green]finished[/color]")
	var next_task = unlock_next(finished_id)
	if next_task and next_task.status == TaskResource.TaskStatus.LOCKED:
		next_task.status = TaskResource.TaskStatus.UNFINISHED
		return
	var all_finished = tasks.all(func(task): return task.status == TaskResource.TaskStatus.FINISHED)
	if all_finished:
		status = QuestStatus.FINISHED
		finished.emit(id)

func unlock_next(current_id: String):
	var task = get_task(current_id)
	var index := tasks.find(task)
	
	if index == -1:
		# Current resource not found in the array
		return null
	
	# Check if there is a next resource
	if index + 1 < tasks.size():
		return tasks[index + 1]
	else:
		return null
	
