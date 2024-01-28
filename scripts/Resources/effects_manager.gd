class_name EffectsManager extends Resource

signal effects_applied(target: Variant)

enum { PLAYER, ENEMY }

var current_effects: Dictionary = {
	PLAYER: [] as Array[EffectResource],
	ENEMY: [] as Array[EffectResource],
}

func add_effect(effect: EffectResource, target):
	current_effects[target].append(effect.duplicate())

func clear_effects(target):
	current_effects[target].clear()

func apply_effetcs(effect_owner: Variant, target: Variant):
	for effect in current_effects[effect_owner]:
		match effect.type:
			EffectResource.EffectType.DAMAGE:
				target.take_damage(effect.value)
			EffectResource.EffectType.PERM_DAMAGE:
				target.take_perm_damage(effect.value)
			EffectResource.EffectType.SKIP_TURN:
				target.skip_turn(effect.value)
			EffectResource.EffectType.DROP_SECRET:
				target.drop_secret(effect.value)
			EffectResource.EffectType.VANISH:
				target.vanish()
	effects_applied.emit(target)
