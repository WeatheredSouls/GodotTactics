extends BaseAbilityEffect
class_name EarthquakeAbilityEffect

@export var earthquakeDepth: int = 3
@export var fallDamage = 5
var fallDistance: int

func Predict(target:Tile):
	if target.content != null:
		var originalHeight: int = target.height
		var newHeight: int = max(originalHeight - earthquakeDepth, 1)
		fallDistance = originalHeight - newHeight
		return -fallDamage * fallDistance
		
	else:
		return 0

func OnApply(target:Tile):
	var value:int = Predict(target)
	for i in earthquakeDepth:
		if target.height > 1:
			target.Shrink()
	battle.board._UpdateMarker()
		
	if target.content && fallDistance > 0:
		var defender:Unit = target.content		
		
		# Apply fall damage to the target
		var s:Stats = defender.get_node("Stats")
		var currentHP = s.GetStat(StatTypes.Stat.HP)
		s.SetStat(StatTypes.Stat.HP, currentHP + value)
		
		Traverse(target)
		return value
		
	return 0

func Traverse(target:Tile):
	var defender:Unit = target.content
	await Fall(defender)

func Fall(defender:Unit):
	var tween = create_tween()
	var duration: float = .1 * fallDistance
		
	tween.tween_property(
		defender,
		"position",
		defender.tile.center(),
		duration
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	await tween.finished
