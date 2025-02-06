extends Node
class_name AbilityRange

@export var horizontal:int = 1
@export var minH:int = 0
@export var vertical:int = 999999

var directionOriented:bool: get = _get_directionOriented
func _get_directionOriented():
	return false

var unit:Unit:
	get:
		return get_node("../../../")

func GetTilesInRange(board:BoardCreator):
	pass
