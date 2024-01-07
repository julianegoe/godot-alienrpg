class_name AbilityResource extends Resource

# damage and defense
@export var name: String = ""
@export var texture: Texture
@export var modifier: int = 0
@export var defense: int = 0

#effects
@export var effects: Array[EffectResource] = []
