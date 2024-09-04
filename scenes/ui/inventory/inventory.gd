class_name Inventory extends Control

signal inventory_visibility_changed(value: bool)

@export var inventory: InventoryResource
@export var hotbar = HotBar
@export var current_tab: ItemResource.ItemType = ItemResource.ItemType.FLORA
@export var current_file_category: InventoryFileCategory.FileCategory = InventoryFileCategory.FileCategory.DETAILS
@onready var file_category_container = $HBoxContainer/Right/Files/InventoryFiles/FileCategoryContainer
@onready var slots_container = $HBoxContainer/Left/VBoxContainer/Slots
@onready var tabs_container = $HBoxContainer/Left/VBoxContainer/TabsContainer

@onready var inventory_label = $HBoxContainer/Left/VBoxContainer/InventoryLabel
@onready var inventory_files = $HBoxContainer/Right/Files/InventoryFiles
		
@onready var current_selected_item: ItemResource

const SLOT_COUNT = 12
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	for tab in tabs_container.get_children():
		tab.tab_selected.connect(_on_tab_selected)
	for slot in slots_container.get_children().slice(0, SLOT_COUNT):
		slot.slot_selected.connect(_on_slot_selected)
	for category in file_category_container.get_children():
		category.category_selected.connect(_on_category_selected)		
	InventoryManager.item_added.connect(_on_item_added)
	InventoryManager.item_removed.connect(_on_item_removed)
	InventoryManager.item_quick_selected.connect(_on_item_quick_selected)
	InventoryManager.item_stashed.connect(_on_item_stashed)
	InventoryManager.item_changed_inventory_position.connect(_on_item_changed_position)
	update_tabs(tabs_container.get_child(current_tab))

	if slots_container.get_child(0).item_resource:
		current_selected_item = slots_container.get_child(0).item_resource
	update_inventory_files(file_category_container.get_child(current_file_category))

func _input(event):
	if event.is_action_pressed("inventory"):
		if visible:
			visible = false
			get_tree().paused = false
	
		else:
			visible = true
			get_tree().paused = true
			PhysicsServer2D.set_active(true)
			
		inventory_visibility_changed.emit(visible)
		
func _on_item_added(_item: ItemResource):
	update_slots()

func _on_item_removed(_item: ItemResource):
	update_slots()

func _on_tab_selected(selected_tab: InventoryTab):
	update_tabs(selected_tab)

func _on_slot_selected(selected_slot: InventorySlot):
	current_selected_item = selected_slot.item_resource
	update_inventory_files(file_category_container.get_child(InventoryFileCategory.FileCategory.DETAILS))

func _on_category_selected(selected_category: InventoryFileCategory):
	update_inventory_files(selected_category)

func _on_item_quick_selected(_item: ItemResource):
	update_slots()

func _on_item_stashed(_item: ItemResource):
	update_slots()

func _on_item_changed_position(_item: ItemResource, _new_position: int):
	update_slots()	
	
func update_slots():
	for slot in slots_container.get_children():
		slot.item_resource = null
		slot.item_icon.hide()
		slot.text = str(0)
		slot.disabled = true
	var data = inventory.filter_items_by(current_tab)
	for item in data:
		if item.inventory_position >= 0 and item.inventory_position < SLOT_COUNT:
			var slot = slots_container.get_child(item.inventory_position)
			slot.item_resource = item
			slot.item_icon.region_rect = item.texture_region_rect
			slot.item_icon.show()
			slot.text = str(item.inventory_quantity)
			if item.inventory_quantity == 0:
				slot.disabled = true
			else:
				slot.disabled = false

func update_tabs(selected_tab: InventoryTab):
	for tab in tabs_container.get_children():
		if tab.is_selected:
			tab.is_selected = false
	selected_tab.is_selected = true
	current_tab = selected_tab.type
	inventory_label.inventory_type = current_tab
	update_slots()


func update_inventory_files(selected_file_category: InventoryFileCategory):
	for category in file_category_container.get_children():
		if category.is_selected:
			category.is_selected = false
	selected_file_category.is_selected = true
	current_file_category = selected_file_category.type
	if current_selected_item:
		inventory_files.item_resource = current_selected_item
		inventory_files.category_type = current_file_category
