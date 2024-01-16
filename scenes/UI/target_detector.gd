extends Node2D

const ARC_POINTS: int = 8

@onready var area_2d = $Area2D

var current_card: AbilityCard
var targeting: bool = false

func _ready():
	Events.card_aim_started.connect(_on_card_aim_started)
	Events.card_aim_ended.connect(_on_card_aim_ended)
	
func _on_card_aim_started(card: AbilityCard):
	if not card.resource.is_single_targeted():
		return
	targeting = true
	area_2d.monitorable = true
	area_2d.monitoring = true
	current_card = card

func _on_card_aim_ended(_card: AbilityCard):
	targeting = false
	area_2d.monitorable = false
	area_2d.monitoring = false
	area_2d.position = Vector2.ZERO
	current_card = null
	
#func _get_points() -> Array:
	#var points = []
	#var start = current_card.global_position
	#start.x += current_card.size.x / 2
	#var target = get_local_mouse_position()
	#var distance = target - start
	#
	#for i in range(ARC_POINTS):
		#var t = (1.0 / ARC_POINTS) * i
		#var x = start.x + (distance.x / ARC_POINTS) * i
		#var y = start.y + ease_out_cubic(t) * distance.y
		#points.append(Vector2(x, y))
	#points.append(target)
	#return points

func ease_out_cubic(number: float):
	return 1.0 - pow(1.0 - number, 3.0)

func _process(_delta):
	if not targeting:
		return
	area_2d.position = get_local_mouse_position()

func _on_area_2d_area_entered(area):
	if not current_card or not targeting:
		return
	if not current_card.targets.has(area):
		current_card.targets.append(area)


func _on_area_2d_area_exited(area):
	if not current_card or not targeting:
		return
	if not current_card.targets.has(area):
		current_card.targets.erase(area)
