extends BaseAbilityEffect
class_name ReviveAbilityEffect

@export var percent:float

func Predict(target:Tile):
	var s:Stats = target.content.get_node("Stats")
	var maxHP = s.GetStat(StatTypes.Stat.MHP)	
	return floori(maxHP * percent)

func OnApply(target:Tile):
	var s:Stats = target.content.get_node("Stats")	
	var value:int = Predict(target)
	s.SetStat(StatTypes.Stat.HP, value)
	return value
