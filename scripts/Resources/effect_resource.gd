class_name EffectResource extends Resource

enum EffectType {
	Damage,
	PermDamage,
	SkipTurn,
	DropSecret,
	Vanish,
}

@export var type: EffectType = EffectType.Damage
@export var value: int = 0
