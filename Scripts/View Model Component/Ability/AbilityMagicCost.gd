extends Node
class_name AbilityMagicCost

@export var amount:int
var ability:Ability

func _ready():
	ability = self.get_parent()
	ability.CanPerformCheck.connect(OnCanPerformCheck)
	ability.DidPerformNotification.connect(OnDidPerformNotification)

func _exit_tree():
	ability.CanPerformCheck.disconnect(OnCanPerformCheck)
	ability.DidPerformNotification.disconnect(OnDidPerformNotification)

func OnCanPerformCheck(exc:BaseException):
	var s:Stats = ability.battle.GetParentUnit(self).get_node("Stats")
	var currentMP = s.GetStat(StatTypes.Stat.MP)
	if currentMP < amount:
		exc.FlipToggle()

func OnDidPerformNotification():
	var s:Stats = ability.battle.GetParentUnit(self).get_node("Stats")
	var currentMP = s.GetStat(StatTypes.Stat.MP)
	s.SetStat(StatTypes.Stat.MP, currentMP - amount)
