extends Node
class_name Consumable

func Consume(targetObj:Node):
	var features:Array[Node] = []	
	features = self.get_parent().get_children()
	
	var filteredArray = features.filter(func(node):return node is Feature)
	for node in filteredArray:
		node.Apply(targetObj)
