extends StatusEffect
class_name StopStatusEffect

var myStats:Stats
var hitIndicator:HitSuccessIndicator

func _enter_tree():
	myStats = self.get_parent().get_parent().get_node("Stats")
	if myStats:
		myStats.WillChangeNotification(StatTypes.Stat.CTR).connect(OnCounterWillChange)
	
	hitIndicator = get_node("/root/Battle/Battle Controller/Hit Success Indicator")
	if hitIndicator:
		hitIndicator.AutomaticHitCheckNotification.connect(OnAutomaticHitCheck)
		
func _exit_tree():
	myStats.WillChangeNotification(StatTypes.Stat.CTR).disconnect(OnCounterWillChange)

func OnCounterWillChange(sender:Stats, exc:ValueChangeException):
	exc.FlipToggle()

func OnAutomaticHitCheck(exc:MatchException):
	var _owner:Unit = GetParentUnit(self)
	if _owner == exc.target:
		exc.FlipToggle()

func GetParentUnit(node:Node):
	var parent = node.get_parent()
	if parent == null:
		return null
	if parent is Unit:
		return parent
	return GetParentUnit(parent)
