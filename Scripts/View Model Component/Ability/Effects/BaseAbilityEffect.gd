extends Node
class_name BaseAbilityEffect

const minDamage:int = -999
const maxDamage:int = 999
var battle:BattleController
var abilityCont:AbilityMenuPanelController
var hitController:HitSuccessIndicator

func _ready():
	battle = get_tree().root.get_node("Battle/Battle Controller")
	abilityCont = battle.abilityMenuPanelController
	hitController = battle.hitSuccessIndicator
	

func Predict(target:Tile):
	pass

func Apply(target:Tile):
	if self.get_node("Ability Effect Target").IsTarget(target) == false:
		return
	if self.get_node("Hit Rate").RollForHit(target):
		print("Hit")
		hitController.HitNotification.emit(OnApply(target))
	else:
		print("Missed")
		hitController.MissedNotification.emit()

func OnApply(target:Tile):
	pass

func GetStat(attacker:Unit, target:Unit, notifier:Signal, startValue:int):
	var mods:Array[ValueModifier]
	var info = Info.new(attacker, target, mods)
	notifier.emit(info)
	
	mods.sort_custom(func(a, b): return a.sortOrder < b.sortOrder)
	
	var value:float = startValue
	for mod in mods:
		value = mod.Modify(startValue, value)
	
	var retValue:int = floori(value)
	retValue = clamp(retValue, minDamage, maxDamage)
	return retValue
