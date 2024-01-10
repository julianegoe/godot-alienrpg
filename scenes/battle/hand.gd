class_name Hand extends MarginContainer

@onready var card_container = $CardContainer

func _ready():
	var cards = card_container.get_children(false)
	for card in cards:
		card.parent = self
		card.reparent_requested.connect(_on_reparent_requested)

func _on_reparent_requested(card: AbilityCard):
	card.reparent(card_container)
