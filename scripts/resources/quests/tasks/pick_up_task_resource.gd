class_name PickUpResource extends TaskResource

var type: TaskResource.TaskType = TaskResource.TaskType.PICK_UP
@export var item: ItemResource:
	set(value):
		item = value
		if item and item.has_signal("quantity_changed"):
			item.quantity_changed.connect(_on_quantity_changed)
@export var TARGET_QUANTITY: int
@export var current_quantity: int:
	set(value):
		current_quantity = value
		if current_quantity == TARGET_QUANTITY:
			status = TaskStatus.FINISHED
			
func _on_quantity_changed(value: int):
	current_quantity = value
