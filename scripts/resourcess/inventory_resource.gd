class_name InventoryResource extends Resource

@export var items: Array[ItemResource]

func filter_items_by(type: ItemResource.ItemType):
	return items.filter(func(item: ItemResource): return item.type == type)

func filter_items_by_hotbar():
		return items.filter(func(item: ItemResource): return item.is_hotbar == true)

func by_hotbar_position(a, b) -> bool:
	if a.hotbar_position < b.hotbar_position:
		return true
	return false
