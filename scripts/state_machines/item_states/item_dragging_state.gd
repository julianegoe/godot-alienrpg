class_name ItemDraggingState extends ItemState

var target_position = -1
var target_item: BaseSlot
var ghost_item: Sprite2D

func enter() -> void:
	create_item_copy()
	print("DRAGGING")	

func exit() -> void:
	pass

func on_button_up():
	if item.ghost_item:
			item.ghost_item.queue_free()
	if target_item:
		target_item.grab_focus()
	if target_position >= 0 and target_item:
		if item is HotbarSlot and target_item is HotbarSlot and target_item != item:
			InventoryManager.change_hotbar_position(item.item_resource, target_position)
		if item is InventorySlot and target_item is InventorySlot and target_item != item:
			InventoryManager.change_inventory_position(item.item_resource, target_position)
		if item is HotbarSlot and target_item is InventorySlot:
			InventoryManager.stash_item(item.item_resource, target_position, 1)
		if item is InventorySlot and target_item is HotbarSlot:
			InventoryManager.quick_select_item(item.item_resource, target_position, 1)
		transition_requested.emit(self, ItemState.State.IDLE)
	else:
		transition_requested.emit(self, ItemState.State.IDLE)

func on_selector_area_entered(area: Area2D):
	target_item = area.get_parent()
	var is_same_type = (item is HotbarSlot and target_item is HotbarSlot) or (item is InventorySlot and target_item is InventorySlot)
	if is_same_type and target_item.disabled:
		target_position = target_item.get_index()
	elif not is_same_type:
		target_position = target_item.get_index()
	else:
		target_position = -1

func on_selector_area_exited(_area):
	target_position = -1 
	
func on_update(_delta):
	var mouse_position = item.get_global_mouse_position()
	item.selector.global_position = mouse_position
	item.ghost_item.global_position = mouse_position

func create_item_copy():
	item.ghost_item = Sprite2D.new()
	item.ghost_item.texture = load("res://assets/tilesets/21bit_item_icons_tileset.png")
	item.ghost_item.set_centered(true)
	item.ghost_item.set_offset(Vector2(3, 2))
	item.ghost_item.region_enabled = true
	item.ghost_item.region_rect = item.item_resource.texture_region_rect
	item.ghost_item.top_level = true
	item.ghost_item.z_index = 1
	item.ghost_item.modulate.a = 0.5
	item.add_child(item.ghost_item)
