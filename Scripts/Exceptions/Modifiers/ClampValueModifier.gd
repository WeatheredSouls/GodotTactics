extends ValueModifier
class_name ClampValueModifier

var _min:float
var _max:float

func _init(sortOrder:int, min:float, max:float ):
	super(sortOrder)
	_min = min
	_max = max
	
func Modify(fromValue:float, toValue:float)->float:
	return clamp(toValue, _min, _max)
