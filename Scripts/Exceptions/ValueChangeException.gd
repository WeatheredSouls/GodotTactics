extends BaseException
class_name ValueChangeException

var _fromValue:float
var _toValue:float
var delta:float :
	get:
		return _toValue - _fromValue
var modifiers:Array[ValueModifier] = []

func _init(fromValue:float, toValue:float):
	super(true)
	_fromValue = fromValue
	_toValue = toValue

func AddModifier(m:ValueModifier):
	modifiers.append(m)

func GetModifiedValue()->float:
	if(modifiers.size() == 0):
		return _toValue
	
	var value = _toValue
	
	modifiers.sort_custom(Compare)
	for modifier in modifiers:
		value = modifier.Modify(_fromValue, value)
	
	return value

func Compare(a:ValueModifier, b:ValueModifier):
	return a.sortOrder < b.sortOrder
