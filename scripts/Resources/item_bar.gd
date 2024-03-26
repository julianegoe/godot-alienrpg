class_name ItemBarResource extends Resource

@export var items: Array[AbilityResource]

func get_equipped() -> AbilityResource:
	var equipped = items.filter(func (ability: AbilityResource): return true if ability.is_selected else false)
	if equipped.size() > 0:
		return equipped[0]
	else:
		return null
		
