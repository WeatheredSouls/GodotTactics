@tool
extends Node
class_name Tile

const stepHeight: float = 0.25
var pos: Vector2i
var height: int

var content: Node
var prev: Tile
var distance: int

func center() ->Vector3:
	return Vector3(pos.x, height * stepHeight, pos.y)

func Match():
	self.scale = Vector3(1, height * stepHeight, 1)
	self.position = Vector3(pos.x, height * stepHeight /2.0, pos.y)

func Grow():
	height += 1
	Match()

func Shrink():
	height -= 1
	Match()

func Load(p: Vector2i, h: int):
	pos = p
	height = h
	Match()

func LoadVector(v: Vector3):
	Load(Vector2i(v.x,v.z),v.y)
