class_name IsolatedSlots extends Control


@onready var slots = $HBoxContainer/VBoxContainer/Slots
@export var inventory: InventoryResource
@export var current_tab: ItemResource.ItemType = ItemResource.ItemType.FLORA
const SLOT_COUNT = 12

func _ready():
	update_slots()
	
func update_slots():
	for slot in slots.get_children():
		slot.item_resource = null
		slot.item_icon.texture = null
		slot.text = str(0)
		slot.disabled = true
	var data = inventory.filter_items_by(current_tab)
	for item in data:
		if item.inventory_position >= 0 and item.inventory_position < SLOT_COUNT:
			var slot = slots.get_child(item.inventory_position)
			slot.item_resource = item
			slot.item_icon.texture = item.icon_texture
			slot.text = str(item.inventory_quantity)
			if item.inventory_quantity == 0:
				slot.disabled = true
			else:
				slot.disabled = false
