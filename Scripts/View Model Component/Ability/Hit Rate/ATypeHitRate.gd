extends HitRate
class_name ATypeHitRate

func Calculate(attacker:Unit, target:Unit):
	if(AutomaticHit(attacker, target)):
		return Final(0)
	
	if(AutomaticMiss(attacker, target)):
		return Final(100)
		
	var evade:int = GetEvade(target)
	evade = AdjustForRelativeFacing(attacker, target, evade)
	evade = AdjustForStatusEffects(attacker, target, evade)
	evade = clamp(evade, 5, 95)
	return Final(evade)

func GetEvade(target:Unit):
	var s:Stats = target.get_node("Stats")
	return clamp(s.GetStat(StatTypes.Stat.EVD), 0, 100)

func AdjustForRelativeFacing(attacker:Unit, target:Unit, rate:int):
	match Directions.GetFacing(attacker, target):
		Directions.Facings.FRONT:
			return rate
		Directions.Facings.SIDE:
			return rate/2
		_:
			return rate/4
