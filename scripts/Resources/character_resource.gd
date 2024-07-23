class_name CharacterResource extends Resource

@export_group("Character Textures")
@export var portrait_texture: Texture
@export var charisma_texture: Texture

@export_group("Character Properties")
@export var display_name: String
@export_range(0, 100, 5) var strength: int = 0
@export_range(0, 100, 5) var intelligence: int = 0
@export_range(0, 100, 5) var charisma: int = 0
@export_range(0, 100, 5) var survival: int = 0
