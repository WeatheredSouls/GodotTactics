extends HitRate
class_name FullTypeHitRate

func Calculate(attacker:Unit, target:Unit):	
	if(AutomaticMiss(attacker, target)):
		return Final(100)
		
	return Final(0)
