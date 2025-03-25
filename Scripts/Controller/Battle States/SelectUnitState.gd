extends BattleState

@export var commandSelectionState: State

func Enter():
	super()
	ChangeCurrentUnit()
	
func ChangeCurrentUnit():
	turnController.roundResume.emit()
	SelectTile(turn.actor.tile.pos)	
	_owner.stateMachine.ChangeState(commandSelectionState)
