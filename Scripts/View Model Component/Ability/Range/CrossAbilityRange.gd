extends AbilityRange

@export var width = 1
var _dirs = [Vector2i(0,1), Vector2i(1,0), Vector2i(0,-1), Vector2i(-1,0)]

func ValidTile(t:Tile):
	return t != null && abs(t.height - unit.tile.height) <= vertical

func GetTilesInRange(board:BoardCreator):
	var retValue:Array[Tile] = []
	var pos:Vector2i = unit.tile.pos
	for dir in _dirs:
		var secDir:Vector2i = Vector2i(1,1) - abs(dir)
		for i in range(minH, horizontal+1):
			for j in range(-width+1, width):
				var tileVector:Vector2i = pos + dir*i + secDir*j
				var tile:Tile = board.GetTile(tileVector)
				if ValidTile(tile):
					retValue.append(tile)	
	return retValue
