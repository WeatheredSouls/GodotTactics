extends StatusEffect
class_name BlindStatusEffect

var hitIndicator:HitSuccessIndicator

func _enter_tree():
	hitIndicator = get_node("/root/Battle/Battle Controller/Hit Success Indicator")
	if hitIndicator:
		hitIndicator.StatusCheckNotification.connect(OnHitRateStatusCheck)
	
func _exit_tree():
	hitIndicator.StatusCheckNotification.disconnect(OnHitRateStatusCheck)

func OnHitRateStatusCheck(info:Info):
	var _owner:Unit = GetParentUnit(self)
	if _owner == info.attacker:
		info.data = info.data + 50
	elif _owner == info.target:
		info.data = info.data - 20

func GetParentUnit(node:Node):
	var parent = node.get_parent()
	if parent == null:
		return null
	if parent is Unit:
		return parent
	return GetParentUnit(parent)
