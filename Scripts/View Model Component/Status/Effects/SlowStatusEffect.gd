extends StatusEffect
class_name SlowStatusEffect

var myStats:Stats
const speedModifier = 0.5

func _enter_tree():
	myStats = self.get_parent().get_parent().get_node("Stats")
	if myStats:
		myStats.WillChangeNotification(StatTypes.Stat.CTR).connect(OnCounterWillChange)
		
func _exit_tree():
	myStats.WillChangeNotification(StatTypes.Stat.CTR).disconnect(OnCounterWillChange)

func OnCounterWillChange(sender:Stats, exc:ValueChangeException):
	exc.AddModifier(MultDeltaModifier.new(0,speedModifier))
