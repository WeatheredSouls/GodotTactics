extends Node3D
class_name Unit

var tile: Tile
var dir: Directions.Dirs = Directions.Dirs.SOUTH

func Place(target: Tile):
	#Make sure old tile location is not still pointing to this unit
	if tile != null && tile.content == self:
		tile.content = null

	#Link unit and tile references
	tile = target
  
	if target != null:
		target.content = self

func Match():
	self.position = tile.center()
	self.rotation_degrees = Directions.ToEuler(dir)
