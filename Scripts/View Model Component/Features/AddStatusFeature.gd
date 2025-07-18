extends Feature
class_name AddStatusFeature

var statusEffect:GDScript
var statusString:String
var conditionString:String
var condition:StatusCondition #So we know what to delete later

func OnApply():
	var status:Status = self.get_parent().get_parent().get_parent().get_node("Status")	
	condition = status.Add(statusEffect, StatusCondition, statusString, conditionString)

func OnRemove():
	if condition:
		condition.Remove()
