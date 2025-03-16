extends Node
class_name AbilityArea

var rangeH:int:
	get:
		return _GetRange().horizontal
		
var rangeMinH:int:
	get:
		return _GetRange().minH
		
var rangeV:int:
	get:
		return _GetRange().vertical

func _GetRange():
	var filtered: Array[Node] = self.get_parent().get_children().filter(func(node): return node is AbilityRange)
	var range:AbilityRange = filtered[0]
	return range

func GetTilesInArea(board:BoardCreator, pos:Vector2i):
	pass
