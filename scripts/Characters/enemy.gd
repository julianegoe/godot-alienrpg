class_name Enemy extends StaticBody2D

@export var display_name: String
@export var health: HealthResource
@export var skill_resource: SkillResource
@export var abilities: Array[AbilityResource]

func _on_vicinity_body_entered(_body):
	Events.battle_started.emit(self)
