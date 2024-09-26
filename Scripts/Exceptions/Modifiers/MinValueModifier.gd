extends ValueModifier
class_name MinValueModifier

var _min:float

func _init(sortOrder:int, min:float ):
	super(sortOrder)
	_min = min

func Modify(fromValue:float, toValue:float)->float:
	return min(toValue, _min)
