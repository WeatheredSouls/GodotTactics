extends BaseAbilityPower
class_name MagicalAbilityPower

@export var level:int

func GetBaseAttack():
	var stats:Stats = battle.GetParentUnit(self).get_node("Stats")
	return stats.GetStat(StatTypes.Stat.MAT)
	
func GetBaseDefense(target:Unit):
	var stats:Stats = target.get_node("Stats")
	return stats.GetStat(StatTypes.Stat.MDF)
	
func GetPower():
	return level
