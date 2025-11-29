extends BattleState

@export var endFacingState:BattleState
@export var commandSelectionState:BattleState

func Enter():
	super()
	turn.hasUnitActed = true
	if(turn.hasUnitMoved):
		turn.lockMove = true
	await Animate()

func Animate():
	#TODO play animations, etc
	
	#TODO apply ability effect, etc
	
	ApplyAbility()
	if(turn.hasUnitMoved):
		_owner.stateMachine.ChangeState(endFacingState)
	else:
		_owner.stateMachine.ChangeState(commandSelectionState)

func ApplyAbility():
	turn.ability.Perform(turn.targets)
