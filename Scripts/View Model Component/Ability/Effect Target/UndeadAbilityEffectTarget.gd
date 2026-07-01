extends AbilityEffectTarget

@export var toggle:bool

func IsTarget(tile:Tile):
	if (tile == null || tile.content == null):
		return false
	
	var undead:Array[Node] = tile.content.find_children("*", "Undead", false)
	var hasComponent:bool = undead.size() > 0
	
	if(hasComponent != toggle):
		return false
	
	var s:Stats = tile.content.get_node("Stats")
	return s != null && s.GetStat(StatTypes.Stat.HP) > 0
