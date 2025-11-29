extends Node
class_name Turn

var actor:Unit
var hasUnitMoved:bool
var hasUnitActed:bool
var lockMove:bool
var startTile:Tile
var startDir: Directions.Dirs
var ability: Ability
var targets:Array[Tile]

func Change(current:Unit):
	actor = current
	hasUnitMoved = false
	hasUnitActed = false
	lockMove = false
	startTile = actor.tile
	startDir = actor.dir
	
func UndoMove():
	hasUnitMoved = false
	actor.Place(startTile)
	actor.dir = startDir
	actor.Match()
