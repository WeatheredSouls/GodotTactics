extends ValueModifier
class_name MultValueModifier

var _toMultiply:float

func _init(sortOrder:int, toMultiply:float):
	super(sortOrder)
	_toMultiply = toMultiply

func Modify(fromValue:float, toValue:float)->float:
	return toValue * _toMultiply
