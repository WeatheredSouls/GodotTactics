extends BaseAbilityMenuState
@export var abilityTargetState:State
@export var categorySelectionState:State

static var category:int
var catalog:AbilityCatalog

func Enter():
	super()
	statPanelController.ShowPrimary(turn.actor)

func Exit():
	super()
	await statPanelController.HidePrimary()

func LoadMenu():
	catalog = turn.actor.get_node("Abilities/Ability Catalog")	
	var container:Node = catalog.GetCategory(category)
	menuTitle = container.name
	
	var count:int = catalog.AbilityCount(container)
	menuOptions.clear()
	
	var locks:Array[bool]
	locks.resize(count)
	
	for i in count:
		var ability:Ability = catalog.GetAbility(category, i)
		var cost:AbilityMagicCost = ability.get_node_or_null("Ability Magic Cost")
		if cost:
			menuOptions.append("{0}: {1}".format([ability.name, cost.amount]))
		else:
			menuOptions.append(ability.name)
		locks[i] = !ability.CanPerform()
	
	abilityMenuPanelController.Show(menuTitle,menuOptions)
	for i in count:
		abilityMenuPanelController.SetLocked(i, locks[i])

func Confirm():
	turn.ability = catalog.GetAbility(category, abilityMenuPanelController.selection)
	_owner.stateMachine.ChangeState(abilityTargetState)

func Cancel():
	_owner.stateMachine.ChangeState(categorySelectionState)
