extends Node
class_name Stats

var _data:Array[int] = []
var _willChangeNotifications = {}
var _didChangeNotifications = {}

func _init():
	_data.resize(StatTypes.Stat.size())
	_data.fill(0)

func GetStat(statType:StatTypes.Stat):
	return _data[statType]

func SetStat(statType:StatTypes.Stat, value:int, allowExceptions:bool = true):
	var oldValue:int = _data[statType]
	if oldValue == value:
		return
	
	if allowExceptions:
		# Allow exceptions to the rule here
		var exc:ValueChangeException = ValueChangeException.new(oldValue,value)
		
		# The notification is unique per stat type
		WillChangeNotification(statType).emit(self, exc)

		# Did anything modify the value?
		value = floori(exc.GetModifiedValue())
		
		# Did something nullify the change?
		if exc.toggle == false || value == oldValue:
			return
		
	_data[statType] = value
	DidChangeNotification(statType).emit(self, oldValue)

func WillChangeNotification(statType:StatTypes.Stat):
	var statName = StatTypes.Stat.keys()[statType]
	
	if(!_willChangeNotifications.has(statName)):
		self.add_user_signal(statName+"_willChange")
		_willChangeNotifications[statName] = Signal(self, statName+"_willChange")
		
	return _willChangeNotifications[statName]

func DidChangeNotification(statType:StatTypes.Stat):
	var statName = StatTypes.Stat.keys()[statType]
	
	if(!_didChangeNotifications.has(statName)):
		self.add_user_signal(statName+"_didChange")
		_didChangeNotifications[statName] = Signal(self, statName+"_didChange")
		
	return _didChangeNotifications[statName]
