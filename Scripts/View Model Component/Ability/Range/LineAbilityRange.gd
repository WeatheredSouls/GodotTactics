extends AbilityRange
@export var width:int = 1

func _get_directionOriented():
	return true

func GetTilesInRange(board:BoardCreator):
	var retValue:Array[Tile] = []
	var pos:Vector2i = unit.tile.pos
	var dir:Vector2i = Directions.ToVector(unit.dir)
	var secDir:Vector2i = Vector2i(1,1) - abs(dir)
	
	for i in range(minH, horizontal+1):
		for j in range(-width+1, width):
			var tileVector:Vector2i = pos + dir*i + secDir*j
			if(tileVector.x > board.max.x || tileVector.x < board.min.x):
				break
			if(tileVector.y > board.max.y || tileVector.y < board.min.y):
				break
			
			var tile:Tile = board.GetTile(tileVector)
			if ValidTile(tile):
				retValue.append(tile)
	
	return retValue
	
func ValidTile(t:Tile):
	return t != null && abs(t.height - unit.tile.height) <= vertical
