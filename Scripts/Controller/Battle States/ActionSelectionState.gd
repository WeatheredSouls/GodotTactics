extends BaseAbilityMenuState
@export var commandSelectionState:State
@export var categorySelectionState:State

static var category:int
var whiteMagicOptions:Array[String] = ["Cure", "Raise"]
var blackMagicOptions:Array[String] = ["Fire", "Ice", "Lightning", "Poison"]

func Enter():
	super()
	statPanelController.ShowPrimary(turn.actor)

func Exit():
	super()
	await statPanelController.HidePrimary()

func LoadMenu():
	if(category == 0):
		menuTitle = "White Magic"
		SetOptions(whiteMagicOptions)
	else:
		menuTitle = "BlackMagic"
		SetOptions(blackMagicOptions)
	abilityMenuPanelController.Show(menuTitle,menuOptions)

func Confirm():
	turn.hasUnitActed = true
	if(turn.hasUnitMoved):
		turn.lockMove = true
	_owner.stateMachine.ChangeState(commandSelectionState)

func Cancel():
	_owner.stateMachine.ChangeState(categorySelectionState)

func SetOptions(options:Array[String]):
	menuOptions.clear()
	for entry in options:
		menuOptions.append(entry)
