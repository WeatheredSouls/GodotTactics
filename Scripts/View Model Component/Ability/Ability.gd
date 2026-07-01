extends Node
class_name Ability

signal CanPerformCheck(exc:BaseException)
signal FailedNotification()
signal DidPerformNotification()

var battle:BattleController

func _ready():
	battle = get_tree().root.get_node("Battle/Battle Controller")

func CanPerform():
	var exc:BaseException = BaseException.new(true)
	CanPerformCheck.emit(exc)
	return exc.toggle

func Perform(targets:Array[Tile]):
	if not CanPerform():
		FailedNotification.emit()
		return
	
	for target in targets:
		_Perform(target)
	DidPerformNotification.emit()

func _Perform(target:Tile):
	var children:Array[Node] = self.find_children("*", "BaseAbilityEffect", false)
	for child in children:
		var effect:BaseAbilityEffect = child as BaseAbilityEffect
		effect.Apply(target)
