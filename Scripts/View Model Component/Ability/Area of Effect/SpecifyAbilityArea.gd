extends AbilityArea

@export var horizontal:int = 2
@export var vertical:int = 999999
var tile:Tile

func GetTilesInArea(board:BoardCreator, pos:Vector2i):
	tile = board.GetTile(pos)
	return board.RangeSearch(tile, ExpandSearch, horizontal)

func ExpandSearch(from:Tile, to:Tile):
	return (from.distance + 1) <= horizontal && abs(to.height - tile.height) <= vertical
