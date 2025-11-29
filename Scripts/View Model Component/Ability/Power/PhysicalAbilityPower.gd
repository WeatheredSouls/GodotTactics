extends BaseAbilityPower
class_name PhysicalAbilityPower

@export var level:int

func GetBaseAttack():
	var stats:Stats = battle.GetParentUnit(self).get_node("Stats")
	return stats.GetStat(StatTypes.Stat.ATK)
	
func GetBaseDefense(target:Unit):
	var stats:Stats = target.get_node("Stats")
	return stats.GetStat(StatTypes.Stat.DEF)
	
func GetPower():
	return level
