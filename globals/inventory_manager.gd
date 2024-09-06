extends Node

signal item_added(item: ItemResource)
signal item_removed(item: ItemResource)
signal item_equipped(item: ItemResource)
signal item_quick_selected(item: ItemResource)
signal item_stashed(item: ItemResource)
signal item_changed_hotbar_position(item: ItemResource, new_position: int)
signal item_changed_inventory_position(item: ItemResource, new_position: int)

@onready var inventory_data: InventoryResource = preload("res://scenes/ui/inventory/inventory_resource.tres")

func add_item(new_item: ItemResource, quantity: int):
	if inventory_data.items.has(new_item):
		new_item.increase_quantity_by(quantity, ItemResource.QuantityType.INVENTORY)
		new_item.is_inventory = true
	else:
		inventory_data.items.append(new_item)
		for index in inventory_data.items.size():
			inventory_data.items[index].hotbar_position = index
			inventory_data.items[index].inventory_position = index
		new_item.increase_quantity_by(quantity, ItemResource.QuantityType.INVENTORY)
	item_added.emit(new_item)

func remove_item(item: ItemResource, quantity: int, quantity_type: ItemResource.QuantityType = ItemResource.QuantityType.INVENTORY):
	if item.total_quantity > 0:
		item.decrease_quantity_by(quantity, quantity_type)
	if item.inventory_quantity == 0:
		item.is_inventory = false
	if item.hotbar_quantity == 0:
		item.is_hotbar = false
	if item.total_quantity == 0:
		inventory_data.items.erase(item)
	item_removed.emit(item)
	
func equip_item(item: ItemResource):
	for inventory_item in inventory_data.items:
		if inventory_item == item:
			item.is_equipped = true
		else:
			item.is_equipped = false
	item_equipped.emit(item)

func quick_select_item(item: ItemResource, new_position: int, quantity: int = 1):
	item.is_hotbar = true
	item.hotbar_position = new_position
	item.decrease_quantity_by(quantity, ItemResource.QuantityType.INVENTORY)
	item.increase_quantity_by(quantity, ItemResource.QuantityType.HOTBAR)
	if item.inventory_quantity == 0:
		item.is_inventory = false
	item_quick_selected.emit(item)

func stash_item(item: ItemResource, new_position: int, quantity: int = 1):
	item.is_inventory = true
	item.inventory_position = new_position
	item.decrease_quantity_by(quantity, ItemResource.QuantityType.HOTBAR)
	item.increase_quantity_by(quantity, ItemResource.QuantityType.INVENTORY)
	if item.hotbar_quantity <= 0:
		item.is_hotbar = false
	item_stashed.emit(item)

func change_inventory_position(item: ItemResource, new_position: int):
	item.inventory_position = new_position
	item_changed_inventory_position.emit(item, new_position)
		
func change_hotbar_position(item: ItemResource, new_position: int):
	item.hotbar_position = new_position
	item_changed_hotbar_position.emit(item, new_position)
