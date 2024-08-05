@tool
class_name InventoryLabel extends TextureRect

var label: Label

@export var inventory_type: ItemResource.ItemType:
	set(value):
		label = $Label
		inventory_type = value
		label.text = name_lookup[inventory_type]

var name_lookup = {
	ItemResource.ItemType.WEAPON: "Weapon Inventory",
	ItemResource.ItemType.FLORA: "Flora Inventory",
	ItemResource.ItemType.ALCHEMY: "Alchemy Inventory",
	ItemResource.ItemType.ITEM: "Item Inventory",
}
