extends BattleState
@export var moveTargetState: State

func Enter():
	super()
	Init()

func Init():
	var saveFile = _owner.board.savePath + _owner.board.fileName
	_owner.board.LoadMap(saveFile)
	
	var p:Vector2i = _owner.board.tiles.keys()[0]
	SelectTile(p)
	
	_owner.cameraController.setFollow(_owner.board.marker)
	
	_owner.stateMachine.ChangeState(moveTargetState)
