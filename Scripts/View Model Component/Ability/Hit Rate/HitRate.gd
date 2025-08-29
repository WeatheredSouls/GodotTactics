extends Node
class_name HitRate

var hitIndicator:HitSuccessIndicator

func _ready():
	hitIndicator = get_node("/root/Battle/Battle Controller/Hit Success Indicator")

func Calculate(attacker:Unit, target:Unit):
	pass

func AutomaticHit(attacker:Unit, target:Unit)->bool:
	var exc:MatchException = MatchException.new(attacker, target)
	hitIndicator.AutomaticHitCheckNotification.emit(exc)
	return exc.toggle

func AutomaticMiss(attacker:Unit, target:Unit)->bool:
	var exc:MatchException = MatchException.new(attacker, target)
	hitIndicator.AutomaticMissCheckNotification.emit(exc)
	return exc.toggle

func AdjustForStatusEffects(attacker:Unit, target:Unit, rate:int)->int:
	var args:Info = Info.new(attacker, target, rate)
	hitIndicator.StatusCheckNotification.emit(args)
	return args.data

func Final(evade:int):
	return 100 - evade
