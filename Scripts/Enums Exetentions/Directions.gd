class_name Directions

enum Dirs{
SOUTH, 
EAST,
NORTH,
WEST 
}

static func GetDirection(t1: Tile, t2: Tile):
	var dir:Directions.Dirs
	var toTile:Vector2i = t1.pos - t2.pos
	if abs(toTile.x) > abs(toTile.y):
		dir = Directions.Dirs.EAST if toTile.x < 0 else Directions.Dirs.WEST
	else:
		dir = Directions.Dirs.SOUTH if toTile.y < 0 else Directions.Dirs.NORTH
  
	return dir

static func ToEuler(d: Dirs):
	return Vector3(0, d * 90, 0)

