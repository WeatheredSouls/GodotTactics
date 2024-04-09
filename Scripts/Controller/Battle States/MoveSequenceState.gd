extends BattleState

@export var SelectUnitState:State

func Enter():
	super()
	Sequence()

func Sequence():  
	var m:Movement = _owner.currentUnit.get_node("Movement")
	_owner.cameraController.setFollow(_owner.currentUnit)
	await m.Traverse(_owner.currentTile)
  
	_owner.cameraController.setFollow(_owner.board.marker)
	_owner.stateMachine.ChangeState(SelectUnitState)
