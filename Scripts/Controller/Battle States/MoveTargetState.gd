extends BattleState

var tiles = []
@export var MoveSequenceState: State
@export var commandSelectionState:State

func Enter():
	super()
	var mover:Movement = turn.actor.get_node("Movement")
	tiles = mover.GetTilesInRange(_owner.board)
	_owner.board.SelectTiles(tiles)
	RefreshPrimaryStatPanel(_owner.board.pos)

func Exit():
	super()
	_owner.board.DeSelectTiles(tiles)
	tiles = null
	await statPanelController.HidePrimary()

func OnMove(e:Vector2i):
	var rotatedPoint = _owner.cameraController.AdjustedMovement(e)
	SelectTile(rotatedPoint + _owner.board.pos)
	RefreshPrimaryStatPanel(_owner.board.pos)

func OnFire(e:int):
	if e == 0:
		if tiles.has(_owner.currentTile):
			_owner.stateMachine.ChangeState(MoveSequenceState)
	else:
		_owner.stateMachine.ChangeState(commandSelectionState)

func Zoom(scroll: int):
	_owner.cameraController.Zoom(scroll)
  
func Orbit(direction: Vector2):
	_owner.cameraController.Orbit(direction)
