extends Resource
class_name PanelAnchor

@export var anchorName:String
@export var myAnchor:Control.LayoutPreset
@export var parentAnchor:Control.LayoutPreset
@export var offset:Vector2
@export var duration:float=.5
@export var trans:Tween.TransitionType=Tween.TRANS_LINEAR
@export var anchorEase:Tween.EaseType=Tween.EASE_IN_OUT

func SetValues(aName, mAnchor, pAnchor, v2offset, dur=.5, tran= Tween.TRANS_LINEAR, aEase=Tween.EASE_IN_OUT):
		anchorName = aName
		myAnchor = mAnchor
		parentAnchor = pAnchor
		offset = v2offset
		duration = dur
		trans = tran
		anchorEase = aEase
