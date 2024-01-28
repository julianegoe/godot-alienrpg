class_name EffectResource extends Resource

enum EffectType {
	DAMAGE,
	PERM_DAMAGE,
	SKIP_TURN,
	DROP_SECRET,
	VANISH,
}

@export var type: EffectType = EffectType.DAMAGE
@export var value: int = 0
