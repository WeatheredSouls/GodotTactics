extends Movement
class_name FlyMovement

func GetTilesInRange(board: BoardCreator):
	var retValue = board.RangeSearch(unit.tile, ExpandSearch, range )
	Filter(retValue)
	return retValue

func ExpandSearch(from:Tile, to:Tile):
	return abs(from.pos.x - to.pos.x) + abs(from.pos.y - to.pos.y) <= range

func Traverse(tile: Tile):  
	#Store the distance  and direction between the start tile and target tile
	var dist:float = sqrt(pow(tile.pos.x - unit.tile.pos.x, 2) + pow(tile.pos.y - unit.tile.pos.y, 2))
	var dir:Directions.Dirs = Directions.GetDirection(unit.tile, tile)
	unit.Place(tile)

	#Fly high enough not to clip through any ground tiles
	var y:float = Tile.stepHeight * 10
	var duration:float = y * 0.25

	var tween = create_tween()

	tween.tween_property(
		jumper,
		"position",
		Vector3(0, y, 0),
		duration
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

	await tween.finished

	#Turn to face the general direction
	await Turn(dir)

	#Move to the correct position
	tween = create_tween()
	tween.tween_property(
		unit,
		"position",
		tile.center(),
		dist * .5
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

	#Land
	tween.tween_property(
		jumper,
		"position",
		Vector3(0, 0, 0),
		duration
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

	await tween.finished
