class_name MenuResource extends Resource

signal equipped_cards_update
signal unequipped_cards_updated

@export var equiped_abilities_array: Array[AbilityResource] = []
var equipped_abilities:
	set(value):
		if equiped_abilities_array.has(value):
			equiped_abilities_array.erase(value)
		else:
			equiped_abilities_array.append(value)
		equipped_cards_update.emit()
	get:
		return equiped_abilities_array

@export var unequiped_abilities_array: Array[AbilityResource] = []
var unequipped_abilities: Array[AbilityResource]:
	set(value):
		if unequiped_abilities_array.has(value):
			unequiped_abilities_array.erase(value)
		else:
			unequiped_abilities_array.append(value)
		unequipped_cards_updated.emit()
	get:
		return unequiped_abilities_array
