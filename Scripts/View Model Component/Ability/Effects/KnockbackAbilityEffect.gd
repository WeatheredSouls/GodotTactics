extends BaseAbilityEffect
class_name KnockbackAbilityEffect

@export var bounceDamage = 5
@export var fallDamage = 5

var knockbackLocation:Tile

func Predict(target:Tile):
	var attacker:Unit = battle.GetParentUnit(self)
	var defender:Unit = target.content
	
	var newDirection:Directions.Dirs = Directions.GetDirection(attacker.tile, target)
	var newLocation:Vector2i = target.pos + Directions.ToVector(newDirection)
	knockbackLocation = battle.board.GetTile(newLocation)
	
	if knockbackLocation == null:
		#Skipping edge cases. Does nothing if no tile to push to.
		#Do you remove character from battle? Damage as if hitting a wall?
		return 0
	
	if knockbackLocation.height == target.height:
		#Successful shove. We need to check for unit on other tile
		if knockbackLocation.content != null:
			return -bounceDamage
		return 0
	
	if knockbackLocation.height < target.height:
		#Shoving down at least one level, this could be painful. Also need to check for unit
		if knockbackLocation.content != null:
			#There is a unit at the bottom of the cliff. This adds complexity. I'll leave this to you.
			return 0
		var fallHeight = target.height - knockbackLocation.height
		return -fallHeight * fallDamage
	
	if knockbackLocation.height > target.height:
		#We hit a wall. We don't move, but will take damage
		return -bounceDamage
	
	return 0

func OnApply(target:Tile):
	var defender:Unit = target.content
	var value:int = Predict(target)

	# Apply the damage to the target
	var s:Stats = defender.get_node("Stats")
	var currentHP = s.GetStat(StatTypes.Stat.HP)
	s.SetStat(StatTypes.Stat.HP, currentHP + value)
	
	# Apply damage to anyone we bumped into
	if knockbackLocation.height == target.height:
		if knockbackLocation.content:
			var bumpStats:Stats = knockbackLocation.content.get_node("Stats")
			var bumpCurrentHP = bumpStats.GetStat(StatTypes.Stat.HP)
			bumpStats.SetStat(StatTypes.Stat.HP, bumpCurrentHP - bounceDamage)
	
	if knockbackLocation != null:
		Traverse(target)
	
	return value

func Traverse(target:Tile):
	var defender:Unit = target.content
	if knockbackLocation.height == target.height:
		if knockbackLocation.content == null:
			defender.Place(knockbackLocation)
			await Bump(defender)
		else:
			await Bounce(defender)
	if knockbackLocation.height < target.height && knockbackLocation.content == null:
		await Bump(defender)
		await Fall(defender)
		defender.Place(knockbackLocation)
	if knockbackLocation.height > target.height:
		await Bounce(defender)
	
func Bump(defender:Unit):
	var tween = create_tween()

	tween.tween_property(
		defender,
		"position",
		Vector3(knockbackLocation.center().x, defender.tile.center().y, knockbackLocation.center().z),
		.25,
	).set_trans(Tween.TRANS_LINEAR)
	await tween.finished

func Fall(defender:Unit):
	var tween = create_tween()
	
	var fallHeight:int =defender.tile.height - knockbackLocation.height
	var duration: float = .1 * fallHeight
		
	tween.tween_property(
		defender,
		"position",
		knockbackLocation.center(),
		duration
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	await tween.finished

func Bounce(defender:Unit):
	#Using lerp we can fine tune where the character bounces to
	var percentTraveled: float = .5
	var midpoint:Vector3 = defender.tile.center().lerp(knockbackLocation.center(), percentTraveled)
	
	var tween = create_tween()

	tween.tween_property(
		defender,
		"position",
		Vector3(midpoint.x, defender.tile.center().y, midpoint.z),
		.25,
	).set_trans(Tween.TRANS_LINEAR)
	
	tween.tween_property(
		defender,
		"position",
		defender.tile.center(),
		.25,
	).set_trans(Tween.TRANS_LINEAR)
	
	await tween.finished
