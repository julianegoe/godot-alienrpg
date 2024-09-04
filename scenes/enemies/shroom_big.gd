class_name ShroomBig extends Enemy

var duplicate_resource: EnemyResource
@export var tethered_entities: Array[Node]

@onready var animation_player = $AnimationPlayer
@onready var tethered = $Tethered
@onready var collision_shape_2d = $HitBox/CollisionShape2D
@onready var hit_box = $HitBox

func _ready():
	tethered.init(tethered_entities)
	duplicate_resource = resource.duplicate()
	
func take_damage(damage: int):
	duplicate_resource.health -= damage

func attack():
	animation_player.play("attack_anticipation")
	await get_tree().create_timer(1).timeout
	animation_player.play("attack")
	hit_box.monitorable = true
	var tween = get_tree().create_tween()
	await tween.tween_property(collision_shape_2d.shape, "radius", 20, 0.5).finished
	hit_box.monitorable = false

func _on_tethered_freed():
	attack()
