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
		var battle:BattleController
		battle = get_tree().root.get_node("Battle/Battle Controller")
		
		return battle.GetParentUnit(self)

func GetTilesInRange(board:BoardCreator):
	pass
