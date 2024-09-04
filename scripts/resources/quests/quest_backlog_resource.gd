class_name QuestBacklogResource extends Resource

@export var backlog: Array[QuestResource]

func filter_quests_by(status: Array[QuestResource.QuestStatus]):
	var callback = func (quest: QuestResource):
		if quest.is_hidden:
			return false
		else:
			return status.any(func (stat): return quest.status == stat)
	return backlog.filter(callback)
	
