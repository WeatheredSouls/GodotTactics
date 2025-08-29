extends HitRate
class_name STypeHitRate

func Calculate(attacker:Unit, target:Unit):
	if(AutomaticMiss(attacker, target)):
		return Final(100)	
	
	if(AutomaticHit(attacker, target)):
		return Final(0)
		
	var res:int = GetResistance(target)
	res = AdjustForStatusEffects(attacker, target, res)
	res = AdjustForRelativeFacing(attacker, target, res)
	
	res = clamp(res, 0, 100)
	return Final(res)

func GetResistance(target:Unit):
	var s:Stats = target.get_node("Stats")
	return clamp(s.GetStat(StatTypes.Stat.RES), 0, 100)

func AdjustForRelativeFacing(attacker:Unit, target:Unit, rate:int):
	match Directions.GetFacing(attacker, target):
		Directions.Facings.FRONT:
			return rate
		Directions.Facings.SIDE:
			return rate - 10
		_:
			return rate - 20
