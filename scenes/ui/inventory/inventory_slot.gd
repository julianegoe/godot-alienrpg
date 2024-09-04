class_name InventorySlot extends BaseSlot

signal slot_selected(slot: InventorySlot)

@onready var item_icon = $ItemIcon
@onready var label = $Label
@onready var clip = $Clip
@onready var selector = $Selector
@onready var state_machine: ItemStateMachine = $StateMachine

var item_resource: ItemResource:
	set(value):
		item_resource = value
		if item_resource and item_resource.is_hotbar:
			clip.show()
		else:
			clip.hide()

var text: String:
	set(value):
		text = value
		if text == "-1":
			label.text = "\u221E"
		else:
			label.text = text

func _ready():
	state_machine.init(self)
		
func _on_pressed():
	state_machine.on_button_pressed()

func _input(event: InputEvent):
	state_machine.input(event)

func _on_button_up():
	state_machine.on_button_up()
	
func _on_button_down():
	state_machine.on_button_down()

func _on_dropable_mouse_entered():
	state_machine.on_dropable_mouse_entered(get_index())

func _on_selector_area_entered(area):
	state_machine.on_selector_area_entered(area)
	
func _on_selector_area_exited(area):
	state_machine.on_selector_area_exited(area)

func _on_focus_entered():
	slot_selected.emit(self)

func _process(delta):
	state_machine.on_update(delta)
