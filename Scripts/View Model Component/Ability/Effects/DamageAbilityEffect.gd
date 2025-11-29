extends BaseAbilityEffect
class_name DamageAbilityEffect

func Predict(target:Tile):
	var attacker:Unit = battle.GetParentUnit(self)
	var defender:Unit = target.content
	
	# Get the attackers base attack stat considering
	# mission items, support check, status check, and equipment, etc
	var attack:int = GetStat(attacker, defender, abilityCont.GetAttackNotification,0)
	
	# Get the targets base defense stat considering
	# mission items, support check, status check, and equipment, etc
	var defense:int = GetStat(attacker, defender, abilityCont.GetDefenseNotification, 0)
	
	# Calculate base damage
	var damage:int = attack - (defense / 2)
	damage = max(damage, 1)
	
	# Get the abilities power stat considering possible variations
	var power:int = GetStat(attacker, defender, abilityCont.GetPowerNotification, 0)
	
	# Apply power bonus
	damage = damage * power / 100
	damage = max(damage,1)
	
	# Tweak the damage based on a variety of other checks like
	# Elemental damage, Critical Hits, Damage multipliers, etc.
	damage = GetStat(attacker, defender, abilityCont.TweakDamageNotification, damage)
	
	# Clamp the damage to a range
	damage = clamp(damage, minDamage, maxDamage)
	return -damage

func OnApply(target:Tile):
	var defender:Unit = target.content
	
	# Start with the predicted damage value
	var value:int = Predict(target)
	
	# Add some random variance
	value = floori(value * randf_range(.9,1.1))
	
	# Apply the damage to the target
	var s:Stats = defender.get_node("Stats")
	var currentHP = s.GetStat(StatTypes.Stat.HP)
	s.SetStat(StatTypes.Stat.HP, currentHP + value)
	return value
