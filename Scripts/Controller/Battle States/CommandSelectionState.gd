extends BaseAbilityMenuState

@export var moveTargetState: State
@export var categorySelectionState: State
@export var selectUnitState: State
@export var exploreState: State

func Enter():
	super()
	statPanelController.ShowPrimary(turn.actor)

func Exit():
	super()
	await statPanelController.HidePrimary()

func LoadMenu():
	if(menuOptions.size() == 0):
		menuTitle = "Commands"
		menuOptions.append("Move")
		menuOptions.append("Action")
		menuOptions.append("Wait")
	
	
	abilityMenuPanelController.Show(menuTitle, menuOptions)
	abilityMenuPanelController.SetLocked(0, turn.hasUnitMoved)
	abilityMenuPanelController.SetLocked(1, turn.hasUnitActed)

func Confirm():
	match(abilityMenuPanelController.selection):
		0:
			_owner.stateMachine.ChangeState(moveTargetState)
		1:
			_owner.stateMachine.ChangeState(categorySelectionState)
		2:
			_owner.stateMachine.ChangeState(selectUnitState)

func Cancel():
	if(turn.hasUnitMoved && !turn.lockMove):
		turn.UndoMove()
		abilityMenuPanelController.SetLocked(0, false)
		SelectTile(turn.actor.tile.pos)
	else:
		_owner.stateMachine.ChangeState(exploreState)
