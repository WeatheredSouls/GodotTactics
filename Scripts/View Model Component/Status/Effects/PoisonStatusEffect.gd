extends StatusEffect
class_name PoisonStatusEffect

var unit:Unit
var turnController

func _enter_tree():
	turnController = get_node("/root/Battle/Battle Controller/Turn Order Controller")
	unit = self.get_parent().get_parent()
	if unit:
		turnController.TurnBeganNotification(unit).connect(OnNewTurn)
		
func _exit_tree():
	turnController.TurnBeganNotification(unit).disconnect(OnNewTurn)

func OnNewTurn():
	var s:Stats = unit.get_node("Stats")
	var currentHP:int = s.GetStat(StatTypes.Stat.HP)
	var maxHP:int = s.GetStat(StatTypes.Stat.MHP)
	var reduce:int = min(currentHP, floori(maxHP * 0.1))
	s.SetStat(StatTypes.Stat.HP, (currentHP - reduce), false)
