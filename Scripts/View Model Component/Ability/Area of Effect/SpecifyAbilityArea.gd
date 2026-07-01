extends AbilityArea

@export var horizontal:int = 2
@export var vertical:int = 999999
var tile:Tile

func GetTilesInArea(board:BoardCreator, pos:Vector2i):
	tile = board.GetTile(pos)
	return board.RangeSearch(tile, ExpandSearch, horizontal)

func ExpandSearch(from:Tile, to:Tile):
	return abs(from.pos.x - to.pos.x) + abs(from.pos.y - to.pos.y) <= horizontal && abs(to.height - tile.height) <= vertical
