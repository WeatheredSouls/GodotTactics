extends Node
class_name Health

var stats:Stats

var HP:int: 
	get:
		return stats.GetStat(StatTypes.Stat.HP)
	set(value):
		stats.SetStat(StatTypes.Stat.HP, value)

var MHP:int:
	get:
		return stats.GetStat(StatTypes.Stat.MHP)
	set(value):
		stats.SetStat(StatTypes.Stat.MHP, value)

func _ready():
	stats = get_node("../Stats")
	stats.WillChangeNotification(StatTypes.Stat.HP).connect(OnHPWillChange)
	stats.DidChangeNotification(StatTypes.Stat.MHP).connect(OnMHPDidChange)

func _exit_tree():
	stats.WillChangeNotification(StatTypes.Stat.HP).disconnect(OnHPWillChange)
	stats.DidChangeNotification(StatTypes.Stat.MHP).disconnect(OnMHPDidChange)

func OnHPWillChange(sender:Stats, vce:ValueChangeException):
	vce.AddModifier(ClampValueModifier.new(999999, 0, MHP))

func OnMHPDidChange(sender:Stats, oldValue:int):
	if MHP > oldValue:
		HP = HP + MHP - oldValue
	else:
		HP = clamp(HP, 0, MHP)
