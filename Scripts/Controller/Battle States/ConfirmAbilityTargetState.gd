extends BattleState

@export var performAbilityState:State
@export var abilityTargetState:State

var tiles
var aa:AbilityArea
var index:int = 0

func Enter():
	super()
	var filtered = turn.ability.get_children().filter(func(node): return node is AbilityArea)
	aa = filtered[0]
	tiles = aa.GetTilesInArea(board, pos)
	board.SelectTiles(tiles)
	FindTargets()
	RefreshPrimaryStatPanel(turn.actor.tile.pos)
	SetTarget(0)

func Exit():
	super()
	board.DeSelectTiles(tiles)
	await statPanelController.HidePrimary()
	await statPanelController.HideSecondary()

func OnMove(e:Vector2i):
	if(e.x > 0 || e.y < 0):
		SetTarget(index + 1)
	else:
		SetTarget(index - 1)
	
func OnFire(e:int):
	if(e == 0):
		if (turn.targets.size() > 0):
			_owner.stateMachine.ChangeState(performAbilityState)
	else:
		_owner.stateMachine.ChangeState(abilityTargetState)

func FindTargets():
	turn.targets = []	
	var children:Array[Node] = turn.ability.get_children()
	var targeters:Array[AbilityEffectTarget]
	targeters.assign(children.filter(func(node): return node is AbilityEffectTarget))
	
	for tile in tiles:
		if(IsTarget(tile, targeters)):
			turn.targets.append(tile)

func IsTarget(tile:Tile, list:Array[AbilityEffectTarget]):
	for item in list:
		if(item.IsTarget(tile)):
			return true
	return false

func SetTarget(target:int):
	index = target
	if index < 0:
		index = turn.targets.size()
	if index >= turn.targets.size():
		index = 0
	if turn.targets.size() > 0:
		RefreshSecondaryStatPanel(turn.targets[index].pos)

func Zoom(scroll: int):
	_owner.cameraController.Zoom(scroll)
  
func Orbit(direction: Vector2):
	_owner.cameraController.Orbit(direction)
