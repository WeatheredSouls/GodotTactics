extends BattleState

var tiles = []
@export var MoveSequenceState: State

func Enter():
	super()
	var mover:Movement = _owner.currentUnit.get_node("Movement")
	tiles = mover.GetTilesInRange(_owner.board)
	_owner.board.SelectTiles(tiles)

func Exit():
	super()
	_owner.board.DeSelectTiles(tiles)
	tiles = null

func OnMove(e:Vector2i):
	var rotatedPoint = _owner.cameraController.AdjustedMovement(e)
	SelectTile(rotatedPoint + _owner.board.pos)

func OnFire(e:int):
	if tiles.has(_owner.currentTile):
		_owner.stateMachine.ChangeState(MoveSequenceState)
	print("Fire: " + str(e))

func Zoom(scroll: int):
	_owner.cameraController.Zoom(scroll)
  
func Orbit(direction: Vector2):
	_owner.cameraController.Orbit(direction)
