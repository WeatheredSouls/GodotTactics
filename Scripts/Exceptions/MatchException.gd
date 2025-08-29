extends BaseException
class_name MatchException

var _attacker:Unit
var _target:Unit

var attacker:Unit:
	get:
		return _attacker
var target:Unit:
	get:
		return _target

func _init(atk:Unit, trgt:Unit):
	super(false)
	_attacker = atk
	_target = trgt
