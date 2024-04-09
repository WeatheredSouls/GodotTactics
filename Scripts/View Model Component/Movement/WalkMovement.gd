extends Movement
class_name WalkMovement

func ExpandSearch(from:Tile, to:Tile):
	#skip if the distance in height between the two tiles is more than the unit can jump
	if abs(from.height - to.height) > jumpHeight:
		return false

	#skip if the tile in occupied by an enemy
	if to.content != null:
		return false

	return super(from, to)

func Walk(target:Tile):
	var tween = create_tween()

	tween.tween_property(
		unit,
		"position",
		target.center(),
		.5,
	).set_trans(Tween.TRANS_LINEAR)
	await tween.finished

func Jump(to:Tile):
	var unitTween = create_tween()

	unitTween.tween_property(
		unit,
		"position",
		to.center(),
		.5,
	).set_trans(Tween.TRANS_LINEAR)

	var jumperTween = create_tween()

	jumperTween.tween_property(
		jumper,
		"position",
		Vector3(0,Tile.stepHeight * 2,0),
		.25
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	jumperTween.tween_property(
		jumper,
		"position",
		Vector3(0,0,0),
		.25
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

	await unitTween.finished

func Traverse(tile: Tile):
	unit.Place(tile)

	#Build a list of way points from unit's
	#starting tile to the destination Tile
	var targets = []
	while tile != null:
		targets.push_front(tile)
		tile = tile.prev

	#move to each waypoint in succession
	for i in range(1, targets.size()):
		var from:Tile = targets[i-1]
		var to:Tile = targets[i]

		var dir: Directions.Dirs = Directions.GetDirection(from, to)

		if unit.dir != dir:
			#This is where you would start playing turn animation if there is one
			await Turn(dir)

		if from.height == to.height:
			#This is where you would start playing walk animation if there is one
			await Walk(to)
		else:
			#This is where you would start playing jump animation if there is one
			await Jump(to)

	#When for loop is finished, return to idle animation if there is one
