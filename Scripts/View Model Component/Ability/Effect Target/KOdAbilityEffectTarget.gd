extends AbilityEffectTarget

func IsTarget(tile:Tile):
	if (tile == null || tile.content == null):
		return false
	
	var s:Stats = tile.content.get_node("Stats")
	return s != null && s.GetStat(StatTypes.Stat.HP) <= 0
