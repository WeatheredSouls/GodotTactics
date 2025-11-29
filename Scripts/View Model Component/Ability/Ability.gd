extends Node
class_name Ability

var battle:BattleController
var abilityController:AbilityMenuPanelController

func _ready():
	battle = get_tree().root.get_node("Battle/Battle Controller")
	abilityController = battle.abilityMenuPanelController

func CanPerform():
	var exc:BaseException = BaseException.new(true)
	abilityController.CanPerformCheck.emit(exc)
	return exc.toggle

func Perform(targets:Array[Tile]):
	if not CanPerform():
		abilityController.FailedNotification.emit()
		return
	
	for target in targets:
		_Perform(target)
	abilityController.DidPerformNotification.emit()

func _Perform(target:Tile):
	var children:Array[Node] = self.find_children("*", "BaseAbilityEffect", false)
	for child in children:
		var effect:BaseAbilityEffect = child as BaseAbilityEffect
		effect.Apply(target)
