extends BattleState

@export var commandSelectionState: State
var index:int = -1

func Enter():
	super()
	ChangeCurrentUnit()

func ChangeCurrentUnit():
	index = (index + 1) % units.size()
	turn.Change(units[index])
	_owner.stateMachine.ChangeState(commandSelectionState)
