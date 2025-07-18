extends Node
class_name Status

signal AddedNotification(StatusEffect)
signal RemovedNotificication(StatusEffect)

func Add(status_effect:GDScript,status_condition:GDScript, effect_name:String = "Status Effect", condition_name:String = "Status Condition"):
	var effect = status_effect.new()
	if not effect is StatusEffect:
		print("Not Status Effect")
		return null
	
	var condition = status_condition.new()
	if not condition is StatusCondition:
		print("Not Status Condition")
		return null
	
	var children:Array[Node] = self.get_children()
	var filtered:Array[StatusEffect]
	filtered.assign(children.filter(func(node): return is_instance_of(node, status_effect)))
	
	if not filtered:
		self.add_child(effect)
		effect.name = effect_name
		AddedNotification.emit(effect)
	else:
		effect = filtered[0]
	
	effect.add_child(condition)
	condition.name = condition_name
	return condition

func Remove(target:StatusCondition):
	var effect:StatusEffect = target.get_parent()
	target.queue_free()
	
	var children:Array[Node] = effect.get_children()
	var condition:Array[StatusCondition]
	condition.assign(children.filter(func(node): return node is StatusCondition && !node.is_queued_for_deletion()))
	if condition.is_empty():
		RemovedNotificication.emit(effect)
		effect.queue_free()
