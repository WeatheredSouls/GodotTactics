extends HitRate
class_name ATypeHitRate

func Calculate(target:Tile):
	var defender = target.content
	if(AutomaticHit(defender)):
		return Final(0)
	
	if(AutomaticMiss(defender)):
		return Final(100)
		
	var evade:int = GetEvade(defender)
	evade = AdjustForRelativeFacing(defender, evade)
	evade = AdjustForStatusEffects(defender, evade)
	evade = clamp(evade, 5, 95)
	return Final(evade)

func GetEvade(target:Unit):
	var s:Stats = target.get_node("Stats")
	return clamp(s.GetStat(StatTypes.Stat.EVD), 0, 100)

func AdjustForRelativeFacing(target:Unit, rate:int):
	match Directions.GetFacing(attacker, target):
		Directions.Facings.FRONT:
			return rate
		Directions.Facings.SIDE:
			return rate/2
		_:
			return rate/4
