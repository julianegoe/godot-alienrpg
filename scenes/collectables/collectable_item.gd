class_name CollectableItem extends Area2D

signal collected
signal player_entered
signal player_exited

enum { ENTITY = 32, CHARACTERS = 128 }

@export var does_respawn: bool = false
@export var resource: ItemResource

var sqids = Sqids.new({
  alphabet = "FxnXM1kBN6cuhsAvjW3Co7l2RePyY8DwaU04Tzt9fHQrqSVKdpimLGIJOgb5ZE",
})
var ID: String
var is_in_vicinity: bool = false

@onready var state: GameStateResource = preload("res://resources/game_state/collectable_state.tres")

func _ready():
	set_collision_layer(ENTITY)
	set_collision_mask(CHARACTERS)
	ID = sqids.encode([1, 2, 3])
	if state.tracked_entities.has(ID) and not does_respawn:
		owner.queue_free()
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)
	self.input_event.connect(_on_input_event)
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	
func _on_body_entered(body):
	if body is Player:
		is_in_vicinity = true
		player_entered.emit()
	
func _on_body_exited(body):
	if body is Player:
		is_in_vicinity = false
		player_exited.emit()

func _on_input_event(_viewport, event: InputEvent, _shape_idx):
	if is_in_vicinity:
		if event.is_action_pressed("interact"):
			get_viewport().set_input_as_handled()
			InventoryManager.add_item(resource, 1)
			state.tracked_entities[ID] = true
			collected.emit()
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_mouse_entered():
	if is_in_vicinity:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
