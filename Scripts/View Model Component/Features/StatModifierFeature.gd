extends Feature
class_name StatModifierFeature

var type:StatTypes.Stat
var amount:int
var stats:Stats:
	get:
		return _target.get_node("Stats")

func OnApply():
	var startValue = stats.GetStat(type)
	stats.SetStat(type, startValue + amount)

func OnRemove():
	var startValue = stats.GetStat(type)
	stats.SetStat(type, startValue - amount)
