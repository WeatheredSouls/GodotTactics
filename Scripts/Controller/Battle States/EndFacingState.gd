extends BattleState

@export var selectUnitState:BattleState
@export var commandSelectionState:BattleState

var startDir: Directions.Dirs

func Enter():
	super()
	startDir = turn.actor.dir
	SelectTile(turn.actor.tile.pos)

func OnMove(e:Vector2i):
	var rotatedPoint = _owner.cameraController.AdjustedMovement(e)
	turn.actor.dir = Directions.ToDir(rotatedPoint)
	turn.actor.Match()

func OnFire(e:int):
	match e:
		0:
			_owner.stateMachine.ChangeState(selectUnitState)
		1:
			turn.actor.dir = startDir
			turn.actor.Match()
			_owner.stateMachine.ChangeState(commandSelectionState)

func Zoom(scroll: int):
	_owner.cameraController.Zoom(scroll)
  
func Orbit(direction: Vector2):
	_owner.cameraController.Orbit(direction)
