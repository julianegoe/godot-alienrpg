class_name PlayerIdleState extends PlayerState

func enter():
	player.debug_label.text = "IDLE"
	set_idle(true)

func exit():
	set_idle(false)
	
func on_input(event: InputEvent):
	if event.is_action("down") or event.is_action("up") or event.is_action("left") or event.is_action("right"):
		transition_requested.emit(self, PlayerState.State.WALK)
	if event.is_action_pressed("interact") and player.equipped_item_type == ItemResource.ItemType.WEAPON:
		match player.equipped_item.weapon_type:
			WeaponResource.WeaponType.MELEE:
				transition_requested.emit(self, PlayerState.State.CHARGE_MELEE)
			WeaponResource.WeaponType.RANGED:
				transition_requested.emit(self, PlayerState.State.CHARGE_RANGED)
	if event.is_action_pressed("skip") and player.speechbubble.is_active:
			player.speechbubble.speed_up_text()

func on_health_exhausted():
	transition_requested.emit(self, PlayerState.State.EXHAUSTED)
	
func set_idle(value: bool):
	player.animation_tree["parameters/conditions/idle"] = value
