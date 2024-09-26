extends ValueModifier
class_name AddValueModifier

var _toAdd:float

func _init(sortOrder:int, toAdd:float):
	super(sortOrder)
	_toAdd = toAdd

func Modify(fromValue:float, toValue:float)->float:
	return toValue + _toAdd
