class_name TaskResource extends Resource

signal finished(id: String)

enum TaskStatus { LOCKED, UNFINISHED, FINISHED }
enum TaskType { PICK_UP }
@export var id: String
@export var name: String
@export var description: String
@export var status: TaskStatus:
	set(value):
		status = value
		if status == TaskStatus.FINISHED:
			finished.emit(id)
		
		
