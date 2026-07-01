extends Node
class_name Mana

var stats:Stats
var turnController:TurnOrderController
var unit:Unit

var MP:int: 
	get:
		return stats.GetStat(StatTypes.Stat.MP)
	set(value):
		stats.SetStat(StatTypes.Stat.MP, value)

var MMP:int:
	get:
		return stats.GetStat(StatTypes.Stat.MMP)
	set(value):
		stats.SetStat(StatTypes.Stat.MMP, value)

func _ready():
	stats = get_node("../Stats")
	stats.WillChangeNotification(StatTypes.Stat.MP).connect(OnHPWillChange)
	stats.DidChangeNotification(StatTypes.Stat.MMP).connect(OnMHPDidChange)
	
	unit = get_node("../")
	turnController = get_node("../../").turnOrderController
	turnController.TurnBeganNotification(unit).connect(OnTurnBegan)
	
func _exit_tree():
	stats.WillChangeNotification(StatTypes.Stat.MP).disconnect(OnHPWillChange)
	stats.DidChangeNotification(StatTypes.Stat.MMP).disconnect(OnMHPDidChange)
	turnController.TurnBeganNotification(unit).disconnect(OnTurnBegan)

func OnHPWillChange(sender:Stats, vce:ValueChangeException):
	vce.AddModifier(ClampValueModifier.new(999999, 0, MMP))

func OnMHPDidChange(sender:Stats, oldValue:int):
	if MMP > oldValue:
		MP = MP + MMP - oldValue
	else:
		MP = clamp(MP, 0, MMP)

func OnTurnBegan():
	if MP < MMP:
		MP = MP + max(floori(MMP * 0.1), 1)
