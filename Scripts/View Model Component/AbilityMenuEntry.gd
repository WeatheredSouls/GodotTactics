extends Node
class_name AbilityMenuEntry

enum States
{
	NONE = 0,
	SELECTED = 1 << 0,
	LOCKED = 1 << 1	
}

@export var bullet:TextureRect
@export var label: Label
@export var normalSprite:Texture2D
@export var selectedSprite:Texture2D
@export var disabledSprite: Texture2D

var _state:States
var State:States :
	get:
		return _state
		
	set(value):
		_state = value
		
		var font_color:String = "theme_override_colors/font_color"
		var font_outline_color:String = "theme_override_colors/font_outline_color"
		
		if IsLocked:
			bullet.texture = disabledSprite
			label.set(font_color, Color.SLATE_GRAY)
			label.set(font_outline_color, Color(0.078431, 0.141176, 0.172549)) #rgb:20, 36, 44
		elif IsSelected:
			bullet.texture = selectedSprite
			label.set(font_color, Color(0.976470, 0.823529, 0.462745)) #rgb:249, 210, 118
			label.set(font_outline_color, Color(1.0, 0.627450, 0.282352)) #rgb:255, 160, 72
		else:
			bullet.texture = normalSprite
			label.set(font_color, Color.WHITE)
			label.set(font_outline_color, Color(0.078431, 0.141176, 0.172549)) #rgb:20, 36, 44

var IsLocked:bool :
	get:
		return (State & States.LOCKED) != States.NONE
	set(value): 	
		if value:
			State |= States.LOCKED
		else:
			State &= ~States.LOCKED
		
var IsSelected:bool :
	get:
		return (State & States.SELECTED) != States.NONE
	set(value):
		if value:
			State |= States.SELECTED
		else:
			State &= ~States.SELECTED

var Title:String :
	get:
		return label.text
	set(value):
		label.text = value
		
func Reset():
	State = States.NONE
