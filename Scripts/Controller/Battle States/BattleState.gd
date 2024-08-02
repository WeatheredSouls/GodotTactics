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
	
func OnQuit():
	get_tree().quit()
