extends BattleState

@export var commandSelectionState:State

func Enter():
	super()
	Sequence()

func Sequence():  
	var m:Movement = turn.actor.get_node("Movement")
	_owner.cameraController.setFollow(turn.actor)
	await m.Traverse(_owner.currentTile)
  
	_owner.cameraController.setFollow(_owner.board.marker)
	
	turn.hasUnitMoved = true
	_owner.stateMachine.ChangeState(commandSelectionState)
