extends BaseAbilityPower
class_name WeaponAbilityPower

func GetBaseAttack():
	var stats:Stats = battle.GetParentUnit(self).get_node("Stats")
	return stats.GetStat(StatTypes.Stat.ATK)
	
func GetBaseDefense(target:Unit):
	var stats:Stats = target.get_node("Stats")
	return stats.GetStat(StatTypes.Stat.DEF)
	
func GetPower():
	var power:int = PowerFromEquippedWeapon()
	return power if power > 0 else UnarmedPower()
	
func PowerFromEquippedWeapon():
	var power = 0
	var eq:Equipment = battle.GetParentUnit(self).get_node("Equipment")
	var item:Equippable = eq.GetItem(EquipSlots.Slot.PRIMARY)
	var features:Array[StatModifierFeature] 
	var children = item.get_children()
	features.assign(children.filter(func(node): return is_instance_of(node, StatModifierFeature)))
	
	for feature in features:
		if feature.type == StatTypes.Stat.ATK:
			power = power + feature.amount
	return power
	
func UnarmedPower():
	var job:Job = battle.GetParentUnit(self).get_node("Job")
	for i in job.statOrder.size():
		if job.statOrder[i] == StatTypes.Stat.ATK:
			return job.baseStats[i]
	return 0
