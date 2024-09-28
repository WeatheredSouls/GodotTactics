extends Node
class_name Feature

var target:Node:
	get:
		return _target

var _target:Node

func Activate(targetObj:Node):
	if _target == null:
		_target = targetObj
		OnApply()

func Deactivate():
	if _target != null:
		OnRemove()
		_target = null
	

func Apply(targetObj:Node):
	_target = targetObj
	OnApply()
	_target = null

func OnApply():
	pass

func OnRemove():
	pass
