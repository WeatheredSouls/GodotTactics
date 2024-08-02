extends BaseAbilityMenuState
@export var commandSelectionState:State
@export var actionSelectionState:State


func LoadMenu():
	if(menuOptions.size() == 0):
		menuTitle = "Action"
		menuOptions.append("Attack")
		menuOptions.append("White Magic")
		menuOptions.append("Black Magic")

	abilityMenuPanelController.Show(menuTitle,menuOptions)
	
func Confirm():
	match( abilityMenuPanelController.selection):
		0:
			Attack()
		1:
			SetCategory(0)
		2:
			SetCategory(1)

func Cancel():
	_owner.stateMachine.ChangeState(commandSelectionState)

func Attack():
	turn.hasUnitActed = true
	if(turn.hasUnitMoved):
		turn.lockMove = true
	_owner.stateMachine.ChangeState(commandSelectionState)

func SetCategory(index:int):
	actionSelectionState.category = index
	_owner.stateMachine.ChangeState(actionSelectionState)
