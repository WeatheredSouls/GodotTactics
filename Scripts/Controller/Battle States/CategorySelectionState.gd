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
	menuOptions.clear()
	menuTitle= "Action"
	menuOptions.append("Attack")
	
	var catalog:AbilityCatalog = turn.actor.get_node("Abilities/Ability Catalog")
		
	for i in catalog.CategoryCount():
		menuOptions.append(catalog.GetCategory(i).name)

	abilityMenuPanelController.Show(menuTitle,menuOptions)
	
func Confirm():
	match( abilityMenuPanelController.selection):
		0:
			Attack()
		_:
			SetCategory(abilityMenuPanelController.selection - 1)

func Cancel():
	_owner.stateMachine.ChangeState(commandSelectionState)

func Attack():
	var abilities:Array[Node] = turn.actor.get_node("Abilities").get_children()
	turn.ability = abilities[0]
	
	_owner.stateMachine.ChangeState(abilityTargetState)

func SetCategory(index:int):
	actionSelectionState.category = index
	_owner.stateMachine.ChangeState(actionSelectionState)
