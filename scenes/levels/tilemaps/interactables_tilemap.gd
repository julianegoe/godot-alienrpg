class_name InteractablesTileMap extends TileMapLayer

@export var player: Player

var is_player_in_vicinity: bool = false
var previous_items_in_vicinity: Array
var info_icons: Array[Icon]

@onready var icon = preload("res://scenes/ui/misc/icon.tscn")

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_action_pressed("left_mouse"):
		var current_tile_position = local_to_map(get_global_mouse_position())
		var current_player_position = local_to_map(player.global_position)
		if is_player_in_surrounding_tiles(current_tile_position, current_player_position):
			var is_interactable = get_custom_data_at(current_tile_position, "is_interactable")
			if is_interactable:
				var key = get_custom_data_at(current_tile_position, "interactables")
				var dialogue_node = get_dialogue_node_for(key)
				player.speechbubble.activate(dialogue_node)
			#get_viewport().set_input_as_handled()
			
func get_custom_data_at(tile_pos: Vector2, data_layer: String) -> Variant:
	var data = get_cell_tile_data(tile_pos)
	if data:
		return data.get_custom_data(data_layer)
	else: return null

func get_dialogue_node_for(interactable: String):
	var lookup = {
		"default": 0,
		"fruit": 1,
		"magazines": 2,
		"mysterious_rug": 3,
		"hole": 4,
		"computer": 0,
		"sequencer": 0,
		"journal": 0,
		"calendar": 0
	}
	return lookup.get(interactable)	
	
func get_surrounding_tiles(current_tile: Vector2) -> Array:
	var surrounding_tiles = []
	var target_tile: Vector2
	for y in range(3):
		for x in range(3):
			target_tile = current_tile + Vector2(x - 1, y - 1)		
			surrounding_tiles.append(target_tile)
	return surrounding_tiles
			
func is_player_in_surrounding_tiles(current_tile, player_pos: Vector2) -> bool:
	var surrounding_tiles = get_surrounding_tiles(current_tile)
	return surrounding_tiles.has(player_pos)
		
func get_items_in_vicinity(current_tile: Vector2) -> Array:
	var surrounding_tiles = get_surrounding_tiles(current_tile)
	var surrounding_interactables = surrounding_tiles.filter(func(tile): return get_custom_data_at(tile, "is_interactable"))
	return surrounding_interactables
		
func create_info_icons(item_tiles) -> void:
	delete_info_icons()
	for item_tile in item_tiles:
		var pos = map_to_local(item_tile) - Vector2(0, 20)
		var new_icon = icon.instantiate()
		new_icon.z_index = 1
		new_icon.position = pos
		info_icons.append(new_icon)
		get_parent().add_child(new_icon)
		new_icon.play_animation()
		
func delete_info_icons() -> void:
	if not info_icons.is_empty():
		for info_icon in info_icons:
			info_icon.queue_free()
		info_icons.clear()

func _process(_delta):
	var player_pos = local_to_map(player.position)
	var current_items_in_vicinity = get_items_in_vicinity(player_pos) 
	if current_items_in_vicinity != previous_items_in_vicinity:
		if not current_items_in_vicinity.is_empty():
			create_info_icons(current_items_in_vicinity)
		elif current_items_in_vicinity.is_empty():
			delete_info_icons()
	previous_items_in_vicinity = current_items_in_vicinity
