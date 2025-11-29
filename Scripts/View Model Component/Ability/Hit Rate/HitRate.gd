extends Node
class_name HitRate

var hitIndicator:HitSuccessIndicator
var attacker:Unit

func _ready():
	var battle:BattleController = get_node("/root/Battle/Battle Controller")
	hitIndicator = battle.get_node("Hit Success Indicator")
	attacker = battle.GetParentUnit(self)

func Calculate(target:Tile):
	pass

func AutomaticHit(target:Unit)->bool:
	var exc:MatchException = MatchException.new(attacker, target)
	hitIndicator.AutomaticHitCheckNotification.emit(exc)
	return exc.toggle

func AutomaticMiss(target:Unit)->bool:
	var exc:MatchException = MatchException.new(attacker, target)
	hitIndicator.AutomaticMissCheckNotification.emit(exc)
	return exc.toggle

func AdjustForStatusEffects(target:Unit, rate:int)->int:
	var args:Info = Info.new(attacker, target, rate)
	hitIndicator.StatusCheckNotification.emit(args)
	return args.data

func Final(evade:int):
	return 100 - evade

func RollForHit(target:Tile):
	var roll:int = randi_range(0, 100)
	var chance:int = Calculate(target)
	return roll <= chance
