extends Node
class_name InputController

signal moveEvent(point:Vector2i)
signal fireEvent(button:int)
signal quitEvent()
signal cameraRotateEvent(point:Vector2)
signal cameraZoomEvent(scroll:int)

var _hor:Repeater = Repeater.new('move_left', 'move_right')
var _ver:Repeater = Repeater.new('move_up', 'move_down')

var buttons = ['fire_1','fire_2','fire_3','fire_4']

var _camZoomUp:ButtonRepeater = ButtonRepeater.new('zoom_up')
var _camZoomDown:ButtonRepeater = ButtonRepeater.new('zoom_down')

var _lastMouse:Vector2

func _process(delta):
	var x = _hor.Update()
	var y = _ver.Update()
	
	if x != 0 || y != 0:
		moveEvent.emit(Vector2i(x,y))
	
	for i in range(buttons.size()):
		if Input.is_action_just_pressed(buttons[i]):
			fireEvent.emit(i)
			
	if Input.is_action_just_pressed('quit'):
		quitEvent.emit()
	
	if _camZoomUp.Update():
		cameraZoomEvent.emit(-1)
		
	if _camZoomDown.Update():
		cameraZoomEvent.emit(1)
		
	var camX = Input.get_axis('camera_right','camera_left')
	var camY = Input.get_axis('camera_down', 'camera_up')

	if camX !=0 || camY !=0:
		cameraRotateEvent.emit(Vector2(camX,camY))
		
	if Input.is_action_just_pressed('camera_activate'):
		_lastMouse = get_viewport().get_mouse_position()

	if Input.is_action_pressed('camera_activate'):
		var currentMouse:Vector2 = get_viewport().get_mouse_position()
		
		if _lastMouse != currentMouse:
			var mouseVector:Vector2 = _lastMouse - currentMouse
			_lastMouse = currentMouse
			var vectorLimit = 10
			var newVector:Vector2 = mouseVector/vectorLimit
			cameraRotateEvent.emit(newVector)
