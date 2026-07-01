extends BaseAbilityEffect
class_name HealAbilityEffect

func Predict(target:Tile):
	var attacker:Unit = battle.GetParentUnit(self)
	var defender:Unit = target.content
	
	return GetStat(attacker, defender, abilityCont.GetPowerNotification, 0)

func OnApply(target:Tile):
	var defender:Unit = target.content
	
	# Start with the predicted damage value
	var value:int = Predict(target)
	
	# Add some random variance
	value = floori(value * randf_range(.9,1.1))
	
	# Clamp the amount to a range
	value = clamp(value, minDamage, maxDamage)
		
	# Apply the damage to the target
	var s:Stats = defender.get_node("Stats")
	var currentHP = s.GetStat(StatTypes.Stat.HP)
	s.SetStat(StatTypes.Stat.HP, currentHP + value)
	return value
