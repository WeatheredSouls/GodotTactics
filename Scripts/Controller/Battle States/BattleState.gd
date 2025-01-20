extends State
class_name BattleState

var _owner: BattleController

var abilityMenuPanelController:AbilityMenuPanelController:
	get:
		return _owner.abilityMenuPanelController

var turn:Turn: 
	get:
		return _owner.turn

var units:Array[Unit]:
	get:
		return _owner.units

var statPanelController:StatPanelController:
	get:
		return _owner.statPanelController

func _ready():
	_owner = get_node("../../")

func AddListeners():
	_owner.inputController.moveEvent.connect(OnMove)
	_owner.inputController.fireEvent.connect(OnFire)
	_owner.inputController.quitEvent.connect(OnQuit)
	_owner.inputController.cameraZoomEvent.connect(Zoom)
	_owner.inputController.cameraRotateEvent.connect(Orbit)

func RemoveListeners():
	_owner.inputController.moveEvent.disconnect(OnMove)
	_owner.inputController.fireEvent.disconnect(OnFire)
	_owner.inputController.quitEvent.disconnect(OnQuit)
	_owner.inputController.cameraZoomEvent.disconnect(Zoom)
	_owner.inputController.cameraRotateEvent.disconnect(Orbit)

func OnMove(e:Vector2i):
	pass

func OnFire(e:int):
	pass

func Zoom(scroll: int):
	pass
		
func Orbit(direction: Vector2):
	pass

func SelectTile(p:Vector2i):
	if _owner.board.pos == p:
		return
	
	_owner.board.pos = p

func GetUnit(p:Vector2i):
	var t:Tile = _owner.board.GetTile(p)
	if t== null || t.content == null:
		return null
	return t.content

func RefreshPrimaryStatPanel(p:Vector2i):
	var target:Unit = GetUnit(p)
	if target != null:
		statPanelController.ShowPrimary(target)
	else:
		statPanelController.HidePrimary()

func RefreshSecondaryStatPanel(p:Vector2i):
	var target:Unit = GetUnit(p)
	if target != null:
		statPanelController.ShowSecondary(target)
	else:
		statPanelController.HideSecondary()

func OnQuit():
	get_tree().quit()
