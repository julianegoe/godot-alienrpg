class_name NpcShopkeeper extends Npc

func _ready():
	$AnimationPlayer.play("idle")
	interaction_icon.hide()

func _on_talkable_entity_approached():
	print("approached")
	interaction_icon.show()
	interaction_icon.play_animation()
	interaction_icon.z_index = 100

func _on_talkable_entity_talked_to():
	print("talked")
	interaction_icon.hide()

func _on_talkable_entity_removed():
	interaction_icon.hide()
