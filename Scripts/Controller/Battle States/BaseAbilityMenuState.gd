extends BattleState
class_name BaseAbilityMenuState

var menuTitle:String
var menuOptions:Array[String] = []

func Enter():
	super()
	SelectTile(turn.actor.tile.pos)
	await LoadMenu()

func Exit():
	super()
	await abilityMenuPanelController.Hide()

func OnFire(e:int):
	if(e == 0):
		Confirm()
	else:
		Cancel()

func OnMove(e:Vector2i):
	if(e.x > 0 || e.y > 0):
		abilityMenuPanelController.Next()
	else:
		abilityMenuPanelController.Previous()

func LoadMenu():
	pass

func Confirm():
	pass

func Cancel():
	pass
