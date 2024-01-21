class_name MenuResource extends Resource

@export var available_slots: Array[SlotResource]
@export var available_cards: Array[CardResource]

func get_equipped_abilities()-> Array:
	var equipped_slots = available_slots.filter(func(slot): return slot.is_equipped)
	return equipped_slots.map(func(slot: SlotResource): return slot.ability)
func get_potential_abilities()-> Array:
	var potential_cards = available_cards.filter(func(card): return not card.disabled)
	return potential_cards.map(func(card): return card.ability)
