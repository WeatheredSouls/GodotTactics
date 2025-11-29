extends Node
class_name BaseAbilityPower

var battle:BattleController
var abilityController:AbilityMenuPanelController

func _ready():
	battle = get_tree().root.get_node("Battle/Battle Controller")
	abilityController = battle.abilityMenuPanelController
	abilityController.GetAttackNotification.connect(OnGetBaseAttack)
	abilityController.GetDefenseNotification.connect(OnGetBaseDefense)
	abilityController.GetPowerNotification.connect(OnGetPower)
	
func _exit_tree():
	abilityController.GetAttackNotification.disconnect(OnGetBaseAttack)
	abilityController.GetDefenseNotification.disconnect(OnGetBaseDefense)
	abilityController.GetPowerNotification.disconnect(OnGetPower)

func OnGetBaseAttack(info:Info):
	if info.attacker != battle.GetParentUnit(self):
		return
		
	var mod:AddValueModifier = AddValueModifier.new(0, GetBaseAttack())
	info.data.append(mod)

func OnGetBaseDefense(info:Info):
	if info.attacker != battle.GetParentUnit(self):
		return
		
	var mod:AddValueModifier = AddValueModifier.new(0, GetBaseDefense(info.target))
	info.data.append(mod)

func OnGetPower(info:Info):
	if info.attacker != battle.GetParentUnit(self):
		return
		
	var mod:AddValueModifier = AddValueModifier.new(0, GetPower())
	info.data.append(mod)

func GetBaseAttack():
	pass
func GetBaseDefense(target:Unit):
	pass
func GetPower():
	pass
