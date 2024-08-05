class_name LevelTileMap extends TileMap

enum Interaction { DEFAULT, LOOKAT, TAKE }
enum Materials { DEFAULT, FRESH_SNOW, AXE, FRUIT, MAGAZINS, MYSTERY_RUG, HOLE }
enum TileLayers { GROUND, SHADOWS, OBJECTS, ITEMS }
enum TILESET_ID { GROUND, OBJECTS, SHADOWS, TREES, ITEMS }

@export var player: Player

var aStar_grid: AStarGrid2D
var tile_position: Vector2
var player_position: Vector2
var is_player_in_vicinity: bool = false
var previous_items_in_vicinity: Array
var info_icons: Array[Icon]

@onready var arrow_cursor = preload("res://assets/cursors/arrow_outlined.png")
@onready var target_cursor = preload("res://assets/cursors/cursor_target.png")
@onready var icon = preload("res://scenes/ui/misc/icon.tscn")

func _input(event):
	var item: Materials
	var interaction_type: Interaction
	if event is InputEventMouseButton and event.pressed:
		tile_position = local_to_map(get_local_mouse_position())
		player_position = local_to_map(player.position)
		if is_player_in_surrounding_tiles(tile_position, player_position):
			interaction_type = get_custom_data_at(tile_position, "type")
			item = get_custom_data_at(tile_position, "material")
			match interaction_type:
				Interaction.LOOKAT:
					player.speechbubble.activate(look(item))
				Interaction.TAKE:
					pick_up(item)
					get_viewport().set_input_as_handled()


func get_tile_data_at(tile_pos: Vector2) -> TileData:
	return get_cell_tile_data(TileLayers.ITEMS, tile_pos)

func get_custom_data_at(tile_pos: Vector2, custom_data_name: String) -> Variant:
	var data = get_tile_data_at(tile_pos)
	if data:
		return data.get_custom_data(custom_data_name)
	else: return 0

func get_resource_for_tile(material_item: int) -> ItemResource:
	var lookup = { 
		Materials.DEFAULT: null,
		Materials.FRESH_SNOW: load("res://resources/items/snowball_resource.tres"),
		Materials.AXE: load("res://resources/items/axe_resource.tres")
	}
	return lookup.get(material_item)		

func pick_up(item: Materials, quantitiy: int = 1) -> void:
	var ability_resource = get_resource_for_tile(item)
	if ability_resource:
		if item == Materials.AXE:
			delete_tile(tile_position, item)
		InventoryManager.add_item(ability_resource, quantitiy)
	
func look(material_item: int):
	var lookup = { 
		Materials.DEFAULT: null,
		Materials.FRUIT: 3,
		Materials.MAGAZINS: 4,
		Materials.MYSTERY_RUG: 5,
		Materials.HOLE: 0
	}
	return lookup.get(material_item)	
	
func delete_tile(tile_pos: Vector2, _item_material: Materials) -> void:
	erase_cell(TileLayers.ITEMS, tile_pos)
	
func get_surrounding_tiles(current_tile: Vector2) -> Array:
	var surrounding_tiles = [current_tile]
	var target_tile
	for y in 3:
		for x in 3:
			target_tile = current_tile + Vector2(x - 1, y - 1)
			if current_tile == target_tile:
				continue
			surrounding_tiles.append(target_tile)
	return surrounding_tiles
			
func is_player_in_surrounding_tiles(current_tile, player_pos: Vector2) -> bool:
	var surrounding_tiles = get_surrounding_tiles(current_tile)
	return surrounding_tiles.has(player_pos)
		
func get_items_in_vicinity(current_tile: Vector2) -> Array:
	var surrounding_tiles = get_surrounding_tiles(current_tile)
	var item_tiles = surrounding_tiles.filter(func(tile): return get_custom_data_at(tile, "material") > 0)
	return item_tiles
		
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

func set_cursor_shape():
	var mouse_pos = local_to_map(get_local_mouse_position())
	var tile_item = get_custom_data_at(mouse_pos, "material")
	if not tile_item == Materials.DEFAULT:
		Input.set_custom_mouse_cursor(arrow_cursor, Input.CURSOR_ARROW)
	else:
		Input.set_custom_mouse_cursor(target_cursor, Input.CURSOR_ARROW)

func getAStarCellId(vCell: Vector2) -> int:
	return int(vCell.y + vCell.x * get_used_rect().size.y)

func _process(_delta):
	set_cursor_shape()
	var player_pos = local_to_map(player.position)
	var current_items_in_vicinity = get_items_in_vicinity(player_pos) 
	if current_items_in_vicinity != previous_items_in_vicinity:
		if not current_items_in_vicinity.is_empty():
			create_info_icons(current_items_in_vicinity)
		elif current_items_in_vicinity.is_empty():
			delete_info_icons()
	previous_items_in_vicinity = current_items_in_vicinity

