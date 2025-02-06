extends AbilityRange

@export var offset:int = 1

func _get_directionOriented():
	return true

func ValidTile(t:Tile):
	return t != null && abs(t.height - unit.tile.height) <= vertical

func GetTilesInRange(board:BoardCreator):
	var retValue:Array[Tile] = []
	var pos:Vector2i = unit.tile.pos
	var dir:Vector2i = Directions.ToVector(unit.dir)
	var secDir:Vector2i = Vector2i(1,1) - abs(dir)
	
	for i in range(minH, horizontal+1):
		for j in range(-i + offset, i - offset + 1):
			var tileVector:Vector2i = pos + dir*i + secDir*j
			var tile:Tile = board.GetTile(tileVector)
			if ValidTile(tile):
				retValue.append(tile)
	
	return retValue
