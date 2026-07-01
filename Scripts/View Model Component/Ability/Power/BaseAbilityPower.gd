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

func OnGetBaseAttack(sender:Node, info:Info):
	if sender.get_parent() != self.get_parent():
		return
	
	var mod:AddValueModifier = AddValueModifier.new(0, GetBaseAttack())
	info.data.append(mod)

func OnGetBaseDefense(sender:Node, info:Info):
	if sender.get_parent() != self.get_parent():
		return
		
	var mod:AddValueModifier = AddValueModifier.new(0, GetBaseDefense(info.target))
	info.data.append(mod)

func OnGetPower(sender:Node, info:Info):
	if sender.get_parent() != self.get_parent():
		return
	
	var mod:AddValueModifier = AddValueModifier.new(0, GetPower())
	info.data.append(mod)

func GetBaseAttack():
	pass
func GetBaseDefense(target:Unit):
	pass
func GetPower():
	pass
