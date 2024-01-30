class_name ButtonRepeater

const _rate: int = 50
var _next: int
var _button: String

func _init(limitButton:String):
	_button = limitButton

func Update():
	if Input.is_action_just_pressed(_button):
		_next = Time.get_ticks_msec() + _rate
		return true
		
	if Input.is_action_pressed(_button): 
		if Time.get_ticks_msec() > _next:
			_next = Time.get_ticks_msec() + _rate
			return true

	return false
