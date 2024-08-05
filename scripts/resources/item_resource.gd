class_name ItemResource extends Resource

enum ItemType { FLORA, WEAPON, ALCHEMY, ITEM, BODY, NONE }
enum QuantityType { TOTAL, INVENTORY, HOTBAR }

@export var type: ItemType

@export_group("Item Textures")

@export var texture_region_rect: Rect2
@export var portrait_texture: Texture

@export_group("Item Properties")

@export var id: String
@export var display_name: String
@export var description: String
var total_quantity: int = 0 # -1 is used as infinite uses
@export var inventory_quantity: int = 0:
	set(value):
		inventory_quantity = value
		if inventory_quantity == -1: 
			total_quantity = -1
			return
		total_quantity = inventory_quantity + hotbar_quantity
	
@export var hotbar_quantity: int = 0:
	set(value):
		hotbar_quantity = value
		if hotbar_quantity == -1: 
			total_quantity = -1
			return
		total_quantity = hotbar_quantity + inventory_quantity 

@export_group("Item Status")
@export var is_equipped: bool
@export var is_hotbar: bool
@export var is_inventory: bool
@export var hotbar_position: int = 0
@export var inventory_position: int = 0

func increase_quantity_by(value: int, quantity_type: QuantityType):
	if total_quantity == -1:
		return
	match quantity_type:
		QuantityType.HOTBAR:
			hotbar_quantity += value
		QuantityType.INVENTORY:
			inventory_quantity += value
	
func decrease_quantity_by(value: int, quantity_type: QuantityType):
	if total_quantity == -1:
		return
	match quantity_type:
		QuantityType.HOTBAR:
			hotbar_quantity -= value
		QuantityType.INVENTORY:
			inventory_quantity -= value
