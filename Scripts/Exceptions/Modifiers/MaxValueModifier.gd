extends ValueModifier
class_name MaxValueModifier

var _max:float

func _init(sortOrder:int, max:float ):
	super(sortOrder)
	_max = max

func Modify(fromValue:float, toValue:float)->float:
	return max(toValue, _max)
