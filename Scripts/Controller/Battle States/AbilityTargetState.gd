extends BattleState

@export var categorySelectionState: State
@export var confirmAbilityTargetState: State

var tiles = []
var ar:AbilityRange

func Enter():
	super()
	var filtered: Array[Node] = turn.ability.get_children().filter(func(node): return node is AbilityRange)
	ar = filtered[0]
	SelectTiles()
	statPanelController.ShowPrimary(turn.actor)
	if(ar.directionOriented):
		RefreshSecondaryStatPanel(pos)

func Exit():
	super()
	board.DeSelectTiles(tiles)
	await statPanelController.HidePrimary()
	await statPanelController.HideSecondary()

func OnMove(e:Vector2i):
	var rotatedPoint = _owner.cameraController.AdjustedMovement(e)
	if(ar.directionOriented):
		ChangeDirection(rotatedPoint)
	else:
		SelectTile(rotatedPoint + pos)
		RefreshSecondaryStatPanel(pos)

func OnFire(e:int):
	if(e == 0):
		if(ar.directionOriented || tiles.has(board.GetTile(pos))):
			_owner.stateMachine.ChangeState(confirmAbilityTargetState)
	else:
		_owner.stateMachine.ChangeState(categorySelectionState)

func ChangeDirection(p:Vector2i):
	var dir:Directions.Dirs = Directions.ToDir(p)
	if(turn.actor.dir != dir):
		board.DeSelectTiles(tiles)
		turn.actor.dir = dir
		turn.actor.Match()
		SelectTiles()
	
func SelectTiles():
	tiles = ar.GetTilesInRange(board)
	board.SelectTiles(tiles)

func Zoom(scroll: int):
	_owner.cameraController.Zoom(scroll)
  
func Orbit(direction: Vector2):
	_owner.cameraController.Orbit(direction)
