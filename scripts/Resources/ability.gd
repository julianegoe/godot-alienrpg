class_name Ability extends Resource

@export var display_name: String = ""
@export var description: String = ""
@export var texture: Texture

# modificators for attacks
@export var attack: int = 0
@export var defense: int = 0

# special effects on success
@export var skip_turns: int = 0
@export var attack_damage: int = 0
@export var permanent_damage: int = 0
@export var drop_secrets: int = 0
@export var evadable: bool = false
