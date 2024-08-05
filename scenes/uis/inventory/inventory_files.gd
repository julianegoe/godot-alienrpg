class_name InventoryFiles extends Control

@export var item_resource: ItemResource:
	set(value):
		item_resource = value
		update_file()
@export var character_resource: CharacterResource
	
@onready var category_label = $CategoryLabel
@onready var portrait_photo: InventoryPortraitPhoto = $PortraitPhoto
@onready var item_description = $DescriptionContainer/ItemDescription
@onready var stats_container = $StatsContainer
@onready var strength_progress = $StatsContainer/StrengthProgress
@onready var intelligence_progress = $StatsContainer/IntelligenceProgress
@onready var charisma_progress = $StatsContainer/CharismaProgress
@onready var survival_progress = $StatsContainer/SurvivalProgress



@onready var category_type: InventoryFileCategory.FileCategory:
	set(value):
		category_type = value
		update_file()

func _ready():
	hide()
	
func update_file():
	show()
	if category_type == InventoryFileCategory.FileCategory.DETAILS:
		category_label.text = "Details"
		portrait_photo.resource = item_resource
		item_description.text = item_resource.description
		stats_container.hide()
	elif category_type == InventoryFileCategory.FileCategory.STATS:
		category_label.text = "Stats"
		portrait_photo.resource = character_resource
		item_description.text = ""
		stats_container.show()
		update_stat_progress()

func update_stat_progress():
	strength_progress.value = character_resource.strength
	intelligence_progress.value = character_resource.intelligence
	charisma_progress.value = character_resource.charisma
	survival_progress.value = character_resource.survival
