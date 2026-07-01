extends AbilityEffectTarget

func IsTarget(tile:Tile):
	if (tile == null):
		return false
	
	return true
