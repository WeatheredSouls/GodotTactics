extends HitRate
class_name STypeHitRate

func Calculate(target:Tile):
	var defender = target.content
	if(AutomaticMiss(defender)):
		return Final(100)	
	
	if(AutomaticHit(defender)):
		return Final(0)
		
	var res:int = GetResistance(defender)
	res = AdjustForStatusEffects(defender, res)
	res = AdjustForRelativeFacing(defender, res)
	
	res = clamp(res, 0, 100)
	return Final(res)

func GetResistance(target:Unit):
	var s:Stats = target.get_node("Stats")
	return clamp(s.GetStat(StatTypes.Stat.RES), 0, 100)

func AdjustForRelativeFacing(target:Unit, rate:int):
	match Directions.GetFacing(attacker, target):
		Directions.Facings.FRONT:
			return rate
		Directions.Facings.SIDE:
			return rate - 10
		_:
			return rate - 20
