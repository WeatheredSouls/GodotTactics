extends BaseAbilityEffect
class_name AbsorbDamageAbilityEffect

@export var effect:BaseAbilityEffect
@export var power:int = 100
var amount:int

func _ready():
	super()
	hitController.HitNotification.connect(OnEffectHit)
	hitController.MissedNotification.connect(OnEffectMissed)

func _exit_tree():
	hitController.HitNotification.disconnect(OnEffectHit)
	hitController.MissedNotification.disconnect(OnEffectMissed)

func Predict(target:Tile):
	return 0

func OnApply(target:Tile):
	var s:Stats = battle.GetParentUnit(self).get_node("Stats")
	var currentHP = s.GetStat(StatTypes.Stat.HP)
	s.SetStat(StatTypes.Stat.HP, currentHP + amount)
	return amount

func OnEffectHit(args, trackedEffect:BaseAbilityEffect):
	if effect == trackedEffect:
		amount = args * -1 * power / 100

func OnEffectMissed(trackedEffect:BaseAbilityEffect):
	if effect == trackedEffect:
		amount = 0
