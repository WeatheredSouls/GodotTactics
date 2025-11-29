extends HitRate
class_name FullTypeHitRate

func Calculate(target:Tile):	
	var defender = target.content
	if(AutomaticMiss(defender)):
		return Final(100)
		
	return Final(0)
