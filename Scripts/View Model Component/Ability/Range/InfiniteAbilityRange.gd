extends AbilityRange

enum Calc{
ALL, 
HEIGHT,
}

@export var option:Calc = Calc.ALL

func GetTilesInRange(board:BoardCreator):
	if option == Calc.ALL:
		return board.tiles.values()
	else:
		var retValue:Array[Tile] = []
		for tile in board.tiles.values():
			if ValidTile(tile):
				retValue.append(tile)
		return retValue

func ValidTile(t:Tile):
	match option: 
		Calc.HEIGHT:
			if t.content != null:
				if t.height % 2 == 0:
					return true
		_:
			return false
	return false
