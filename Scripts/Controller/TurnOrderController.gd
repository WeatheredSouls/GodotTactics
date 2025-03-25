extends Node
class_name TurnOrderController

const turnActivation:int = 1000
const turnCost:int = 500
const moveCost:int = 300
const actionCost:int = 200

signal roundBeganNotification()
signal turnCheckNotification(exc:BaseException)
signal turnCompletedNotification(unit:Unit)
signal roundEndedNotification()
signal roundResume()

func _ready():
	Round()

func Round():
	var bc:BattleController = get_parent()
	await roundResume
	while true:
		roundBeganNotification.emit()
		
		var units:Array[Unit] = bc.units.duplicate()
		for unit in units:
			var s:Stats = unit.get_node("Stats")
			s.SetStat(StatTypes.Stat.CTR, s.GetStat(StatTypes.Stat.CTR) + s.GetStat(StatTypes.Stat.SPD)) 
			
		units.sort_custom(func(a,b): return GetCounter(a) > GetCounter(b))
		
		for unit in units:
			if(CanTakeTurn(unit)):
				bc.turn.Change(unit)
				await roundResume
				var cost:int = turnCost
				if(bc.turn.hasUnitMoved):
					cost+= moveCost
				if(bc.turn.hasUnitActed):
					cost+= actionCost
				
				var s:Stats = unit.get_node("Stats")
				s.SetStat(StatTypes.Stat.CTR, s.GetStat(StatTypes.Stat.CTR) - cost, false) 
				turnCompletedNotification.emit(unit)
		roundEndedNotification.emit()
				
func CanTakeTurn(target:Unit):
	var exc:BaseException = BaseException.new( GetCounter(target) >= turnActivation)
	turnCheckNotification.emit(exc)
	return exc.toggle
	
func GetCounter(target:Unit):
	var s:Stats = target.get_node("Stats")
	return s.GetStat(StatTypes.Stat.CTR)
