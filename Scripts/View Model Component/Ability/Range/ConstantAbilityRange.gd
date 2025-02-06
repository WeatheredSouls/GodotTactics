extends AbilityRange

func GetTilesInRange(board: BoardCreator):
	var retValue = board.RangeSearch(unit.tile, ExpandSearch, horizontal )
	return retValue

func ExpandSearch(from:Tile, to:Tile):
	var dist = abs(from.pos.x - to.pos.x) + abs(from.pos.y - to.pos.y)
	return  dist <= horizontal && dist >= minH && abs(from.height - to.height) <= vertical
