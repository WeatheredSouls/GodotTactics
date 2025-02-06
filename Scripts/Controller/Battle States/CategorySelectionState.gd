extends BaseAbilityMenuState
@export var commandSelectionState:State
@export var actionSelectionState:State
@export var abilityTargetState:State

func Enter():
	super()
	statPanelController.ShowPrimary(turn.actor)

func Exit():
	super()
	await statPanelController.HidePrimary()

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
	var abilities:Array[Node] = turn.actor.get_node("Abilities").get_children()
	turn.ability = abilities[0]
	
	_owner.stateMachine.ChangeState(abilityTargetState)

func SetCategory(index:int):
	actionSelectionState.category = index
	_owner.stateMachine.ChangeState(actionSelectionState)
