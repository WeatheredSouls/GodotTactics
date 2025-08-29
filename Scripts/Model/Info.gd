extends Node
class_name Info

var _attacker:Unit
var _target:Unit

var data

var attacker:Unit:
	get:
		return _attacker
var target:Unit:
	get:
		return _target

func _init(unitA:Unit, unitB:Unit, arg):
	_attacker = unitA
	_target = unitB
	data = arg
