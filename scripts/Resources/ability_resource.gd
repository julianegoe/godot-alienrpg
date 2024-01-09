class_name AbilityResource extends Resource

enum Target { PLAYER, SINGLE_ENEMY, ALL_ENEMIES, EVERYONE }

@export_group("Card Attributes")
@export var id: String = ""
@export var name: String = ""
@export var description: String = ""
@export var texture: Texture

@export_group("Ability Stats")
@export var attack_modifier: int = 0
@export var defense_modifier: int = 0
@export var target: Target = Target.SINGLE_ENEMY

#effects
@export var effects: Array[EffectResource] = []

#functions
func is_single_targeted():
	return target == Target.SINGLE_ENEMY
