extends AddStatusFeature
class_name AddPoisonStatusFeature

func _ready():
	statusEffect = PoisonStatusEffect
	statusString = "Poison"
	conditionString = "Status Condition"
