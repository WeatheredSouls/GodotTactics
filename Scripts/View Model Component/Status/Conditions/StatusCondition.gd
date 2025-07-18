extends Node
class_name StatusCondition

func Remove():
	var status:Status = self.get_parent().get_parent()
	if status:
		status.Remove(self)
