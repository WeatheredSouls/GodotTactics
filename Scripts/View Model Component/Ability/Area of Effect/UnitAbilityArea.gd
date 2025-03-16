extends AbilityArea

func GetTilesInArea(board:BoardCreator, pos:Vector2i):
	var retValue:Array[Tile] = []
	var tile:Tile = board.GetTile(pos)
	if tile != null:
		retValue.append(tile)
	
	return retValue
