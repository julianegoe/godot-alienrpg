class_name HotbarSlot extends BaseSlot

signal slot_selected(slot: HotbarSlot)

@onready var tooltip = $Tooltip
@onready var item_icon = $ItemIcon
@onready var label = $Control/Label
@onready var selector = $Selector
@onready var state_machine: ItemStateMachine = $StateMachine

const TOOLTIP_OFFSET = Vector2(10, -30)
var item_resource: ItemResource

var text: String:
	set(value):
		text = value
		if text == "-1":
			label.text = "\u221E"
		else:
			label.text = text
	get:
		return text

func _ready():
	tooltip.hide()
	state_machine.init(self)
		
func _on_pressed():
	slot_selected.emit(self)
	state_machine.on_button_pressed()

func _input(event: InputEvent):
	state_machine.input(event)

func _on_button_up():
	state_machine.on_button_up()
	
func _on_button_down():
	state_machine.on_button_down()
	
func _on_selector_area_entered(area):
	state_machine.on_selector_area_entered(area)

func _on_selector_area_exited(area):
	state_machine.on_selector_area_exited(area)

func show_tooltip():
	if disabled == false:
		tooltip.display_name.text = item_resource.display_name
		tooltip.description.text = item_resource.description
		tooltip.global_position = get_global_mouse_position() + TOOLTIP_OFFSET
		tooltip.show()

func _process(delta):
	state_machine.on_update(delta)

func _on_mouse_entered():
	show_tooltip()

func _on_mouse_exited():
	tooltip.hide()
