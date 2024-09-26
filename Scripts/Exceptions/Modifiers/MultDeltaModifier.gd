extends ValueModifier
class_name MultDeltaModifier

var _toMultiply:float

func _init(sortOrder:int, toMultiply:float):
	super(sortOrder)
	_toMultiply = toMultiply

func Modify(fromValue:float, toValue:float)->float:
	var delta:float = toValue - fromValue
	return fromValue + delta * _toMultiply
