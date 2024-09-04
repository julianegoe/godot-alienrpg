class_name TetheredEntities extends Node2D

signal freed

var entities: Array[Node]

func init(tethered: Array[Node]):
	entities = tethered
	if not entities.is_empty():
		for entity in entities:
			if entity.has_signal("has_died"):
				entity.has_died.connect(_on_tethered_entity_has_died)
				
func _on_tethered_entity_has_died(entity: Node):
	var index = entities.find(entity)
	entities.remove_at(index)
	if entities.is_empty():
		freed.emit()
