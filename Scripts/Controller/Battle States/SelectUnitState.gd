extends BattleState

@export var moveTargetState: State

func OnMove(e:Vector2i):
	var rotatedPoint = _owner.cameraController.AdjustedMovement(e)
	SelectTile(rotatedPoint + _owner.board.pos)

func OnFire(e:int):
	print("Fire: " + str(e))
	if _owner.currentTile != null:
		var content:Node = _owner.currentTile.content
		if content != null:
			_owner.currentUnit = content
			_owner.stateMachine.ChangeState(moveTargetState)

func Zoom(scroll: int):
	_owner.cameraController.Zoom(scroll)

func Orbit(direction: Vector2):
	_owner.cameraController.Orbit(direction)
