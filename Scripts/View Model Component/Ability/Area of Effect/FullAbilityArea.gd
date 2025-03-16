extends AbilityArea

func GetTilesInArea(board:BoardCreator, pos:Vector2i):
	return _GetRange().GetTilesInRange(board)
