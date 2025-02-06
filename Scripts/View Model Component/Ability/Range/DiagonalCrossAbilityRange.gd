extends AbilityRange

@export var width = 1
var _dirs = [Vector2i(1,1), Vector2i(-1,-1), Vector2i(1,-1), Vector2i(-1,1)]

func ValidTile(t:Tile):
	return t != null && abs(t.height - unit.tile.height) <= vertical

func GetTilesInRange(board:BoardCreator):
	var retValue:Array[Tile] = []
	var pos:Vector2i = unit.tile.pos
	
	for i in range(minH, horizontal+1):
		for dir in _dirs:
			var sideA:Vector2i = Vector2i(-dir.x, dir.y)
			var sideB:Vector2i = Vector2i(dir.x, -dir.y)
			var vectorA:Vector2i
			var vectorB:Vector2i
			
			for w in range(1, width+1):
				if w == 1:
					var tileVector:Vector2i = pos + dir*i
					var tile:Tile = board.GetTile(tileVector)
					if ValidTile(tile):
						retValue.append(tile)
					vectorA = dir * i
					vectorB = dir * i

				else:	
					vectorA = Vector2i(vectorA.x + sideA.x * w%2, vectorA.y + sideA.y * (1 - w%2))
					vectorB = Vector2i(vectorB.x + sideB.x * (1 - w%2), vectorB.y + sideB.y *  w%2)

					if (abs(vectorA.x) + abs(vectorA.y)) <= horizontal * 2: 
						var tile:Tile = board.GetTile(vectorA + pos)
						if ValidTile(tile):
							retValue.append(tile)
					if (abs(vectorB.x) + abs(vectorB.y)) <= horizontal * 2:
						var tile:Tile = board.GetTile(vectorB + pos)
						if ValidTile(tile):
							retValue.append(tile)
	
	return retValue
