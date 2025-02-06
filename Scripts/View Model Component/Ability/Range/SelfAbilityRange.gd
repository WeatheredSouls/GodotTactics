extends AbilityRange

func GetTilesInRange(board:BoardCreator):
	var retValue:Array[Tile] = []
	retValue.append(unit.tile)
	return retValue
