extends TileMap

signal pick_up_material(ability: AbilityResource)

@export var player: Player
var tile_position: Vector2
var player_position: Vector2
var is_player_in_vicinity: bool = false
var icon = preload("res://scenes/UI/Icon.tscn")
var info_icons: Array[Icon]

enum Materials { DEFAULT, FRESH_SNOW }

func _unhandled_input(event):
	var item: Materials
	if event is InputEventMouseMotion:
		var mouse_pos = local_to_map(get_local_mouse_position())
		var tile_item = get_custom_data_at(mouse_pos, "material")
		if tile_item == Materials.FRESH_SNOW:
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		else:
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	if event is InputEventMouseButton and event.pressed:
		tile_position = local_to_map(get_local_mouse_position())
		player_position = local_to_map(player.position)
		if is_player_in_surrounding_tiles(tile_position, player_position):
			item = get_custom_data_at(tile_position, "material")
			var ability = pick_up(item)
			if ability:
				pick_up_material.emit(ability)
				

func get_tile_data_at(tile_pos: Vector2) -> TileData:
	return get_cell_tile_data(1, tile_pos)

func get_custom_data_at(tile_pos: Vector2, custom_data_name: String) -> Variant:
	var data = get_tile_data_at(tile_pos)
	if data:
		return data.get_custom_data(custom_data_name)
	else: return 0

func pick_up(material_item: int):
	var lookup = {
		Materials.DEFAULT: null,
		Materials.FRESH_SNOW: load("res://resources/abilities/snow.tres")
	}
	return lookup.get(material_item)		

func get_surrounding_tiles(current_tile: Vector2):
	var surrounding_tiles = []
	var target_tile
	for y in 3:
		for x in 3:
			target_tile = current_tile + Vector2(x - 1, y - 1)
			if current_tile == target_tile:
				continue
			surrounding_tiles.append(target_tile)
	return surrounding_tiles
			
func is_player_in_surrounding_tiles(current_tile, player_pos: Vector2):
	var surrounding_tiles = get_surrounding_tiles(current_tile)
	return surrounding_tiles.has(player_pos)
		
func snowtiles_in_vicinity(current_tile: Vector2):
	var surrounding_tiles = get_surrounding_tiles(current_tile)
	var snow_tiles = surrounding_tiles.filter(func(tile): return get_custom_data_at(tile, "material") == 1)
	return snow_tiles

func create_info_icons(snow_tiles):
	for snow_tile in snow_tiles:
		var pos = map_to_local(snow_tile) - Vector2(0, 20)
		var new_icon = icon.instantiate()
		new_icon.position = pos
		new_icon.play_animation()
		info_icons.append(new_icon)
		get_parent().add_child(new_icon)

func delete_info_icons():
	if not info_icons.is_empty():
		for info_icon in info_icons:
			info_icon.queue_free()
		info_icons.clear()
	
func _process(_delta):
	var player_pos = local_to_map(player.position)
	if not snowtiles_in_vicinity(player_pos).is_empty() and not is_player_in_vicinity:
		create_info_icons(snowtiles_in_vicinity(player_pos))
		is_player_in_vicinity = true
	elif snowtiles_in_vicinity(player_pos).is_empty() and is_player_in_vicinity:
		delete_info_icons()
		is_player_in_vicinity = false
		
