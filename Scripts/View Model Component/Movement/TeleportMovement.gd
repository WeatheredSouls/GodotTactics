extends Movement
class_name TeleportMovement

func GetTilesInRange(board: BoardCreator):
	var retValue = board.RangeSearch(unit.tile, ExpandSearch, range )
	Filter(retValue)
	return retValue

func ExpandSearch(from:Tile, to:Tile):
	return abs(from.pos.x - to.pos.x) + abs(from.pos.y - to.pos.y) <= range

func Traverse(tile: Tile):
	unit.Place(tile)

	var spinTween = create_tween()
	spinTween.tween_property(
		jumper,
		"rotation",
		Vector3(0,360, 0),
		.5
	).set_trans(Tween.TRANS_LINEAR)

	var scaleTween = create_tween()
	scaleTween.tween_property(
		jumper,
		"scale",
		Vector3(0,0,0),
		0.5
	)
	await scaleTween.finished

	unit.position = tile.center()

	spinTween = create_tween()
	spinTween.tween_property(
		jumper,
		"rotation",
		Vector3(0,0, 0),
		.5
	).set_trans(Tween.TRANS_LINEAR)

	scaleTween = create_tween()
	scaleTween.tween_property(
		jumper,
		"scale",
		Vector3(1,1,1),
		0.5
	)  
	await scaleTween.finished
