class_name Item extends Node2D

signal take_item(item: Item)

@export var icon_texture: Texture
@export var item_texture: Texture
@export var ability: AbilityResource

@onready var texture_button = $TextureButton
@onready var icon = $Ui/Icon


func _ready():
	icon.sprite_texture = icon_texture
	texture_button.texture_normal = item_texture


func _on_texture_button_pressed():
	take_item.emit(self)

func _on_vicinity_body_entered(body):
	if body is Player:
		icon.show()
		icon.play_animation()


func _on_vicinity_body_exited(body):
	if body is Player:
		icon.hide()
