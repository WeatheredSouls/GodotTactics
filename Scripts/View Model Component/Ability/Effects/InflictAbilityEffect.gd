extends BaseAbilityEffect
class_name InflictAbilityEffect

@export var status_effect:GDScript
@export var effect_name:String
@export var duration:int

func Predict(target:Tile):
	return 0

func OnApply(target:Tile):
	var unit:Unit = target.content
	if unit == null:
		return 0
	
	var status:Status = unit.get_node("Status")
	
	var condition:DurationStatusCondition
	condition = status.Add(status_effect , DurationStatusCondition, effect_name, "Duration Condition")
	condition.duration = duration
	
	return 0
