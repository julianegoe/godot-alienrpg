class_name Enemy extends StaticBody2D

signal defeated
signal vanished

@onready var health_bar = $Ui/HealthBar
@onready var health_label = $Ui/HealthLabel
@onready var ui = $Ui
@onready var effects_manager = preload("res://resources/effects_manager.tres")

@export var display_name: String
@export var health: HealthResource
		
@export var skill_resource: SkillResource
@export var abilities: Array[AbilityResource]

var has_perm_damage_for: int = 0

func _ready():
	health_bar.max_value = health.health
	health.health_changed.connect(_on_health_changed)
	
func _on_vicinity_body_entered(_body):
	Events.battle_started.emit(self)

func attack(target: Variant):
	var random_ability = abilities.pick_random()
	print("enemy attacks with ", random_ability.name)
	if random_ability:
		await get_tree().create_timer(3.0).timeout
		for effect in random_ability.effects:
			effects_manager.add_effect(effect, EffectsManager.ENEMY)
			effects_manager.apply_effetcs(EffectsManager.ENEMY, target)
			effects_manager.clear_effects(EffectsManager.ENEMY)
	await get_tree().create_timer(1.0).timeout

func take_damage(value: int):
	health.health -= value
	take_perm_damage(has_perm_damage_for)
	if health.health == 0:
		defeated.emit()

func take_perm_damage(value: int):
	has_perm_damage_for = value
	if has_perm_damage_for > 0:
		health.health -= value
		if health.health == 0:
			defeated.emit()

func skip_turn(_value: int):
	pass

func drop_secret():
	# implement secrets resource
	print("secrets dropped")

func vanish():
	print("vanish")
	vanished.emit()

func _on_health_changed(value: int):
	var tween = create_tween()
	await tween.tween_property(health_bar, "value", value, 0.5).finished
	health_label.text = str(value)
