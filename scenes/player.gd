extends CharacterBody2D
class_name Player

var _controller: PlayerController

@onready var _controller_container = $ControllerContainer

func _ready():
	set_controller(HumanController.new(self))
	
func set_controller(controller: PlayerController) -> void:
	for child in _controller_container.get_children():
		child.queue_free()
	_controller = controller    
	_controller_container.add_child(_controller)
		
		
		
