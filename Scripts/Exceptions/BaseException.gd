extends Node
class_name BaseException

var toggle:bool
var defaultToggle:bool

func _init(default:bool):
	defaultToggle = default
	toggle = defaultToggle

func FlipToggle():
	toggle = !defaultToggle
