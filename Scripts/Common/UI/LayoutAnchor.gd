extends Panel
class_name LayoutAnchor

func GetParentAnchor(anchor: Control.LayoutPreset) -> Vector2:
	var retValue:Vector2 = Vector2.ZERO
	#Set the x value of our return
	match anchor:
		Control.PRESET_TOP_RIGHT, Control.PRESET_BOTTOM_RIGHT, Control.PRESET_CENTER_RIGHT:
			retValue.x = 1
		
		Control.PRESET_CENTER_TOP, Control.PRESET_CENTER_BOTTOM, Control.PRESET_CENTER:
			retValue.x = .5
		
		_:
			retValue.x = 0
	
	#Set the y value of our return
	match anchor:
		Control.PRESET_BOTTOM_LEFT, Control.PRESET_BOTTOM_RIGHT, Control.PRESET_CENTER_BOTTOM:
			retValue.y = 1
		
		Control.PRESET_CENTER_LEFT, Control.PRESET_CENTER_RIGHT, Control.PRESET_CENTER:
			retValue.y = .5
		
		_:
			retValue.y = 0
			
	return retValue

func GetMyOffsets(anchor: Control.LayoutPreset, offset: Vector2) -> Rect2:
	var retValue:Rect2 = Rect2()
	
	#Set the x value of our return
	match anchor:
		Control.PRESET_TOP_RIGHT, Control.PRESET_BOTTOM_RIGHT, Control.PRESET_CENTER_RIGHT:
			retValue.position.x = -1 * self.size.x
		
		Control.PRESET_CENTER_TOP, Control.PRESET_CENTER_BOTTOM, Control.PRESET_CENTER:
			retValue.position.x = -.5 * self.size.x
		
		_:
			retValue.position.x = 0
	
	#Set the y value of our return
	match anchor:
		Control.PRESET_BOTTOM_LEFT, Control.PRESET_BOTTOM_RIGHT, Control.PRESET_CENTER_BOTTOM:
			retValue.position.y = -1 * self.size.y
		
		Control.PRESET_CENTER_LEFT, Control.PRESET_CENTER_RIGHT, Control.PRESET_CENTER:
			retValue.position.y = -.5 * self.size.y
		
		_:
			retValue.position.y = 0
	
	retValue.position += offset
	retValue.end = retValue.position + self.size
	return retValue

func SnapToAnchorPosition(myAnchor:Control.LayoutPreset, parentAnchor:Control.LayoutPreset, offset:Vector2):
	var parentVector:Vector2 = GetParentAnchor(parentAnchor)
	var myOffsets:Rect2 = GetMyOffsets(myAnchor, offset)
	
	self.anchor_left = parentVector.x
	self.anchor_right = parentVector.x
	self.anchor_top = parentVector.y
	self.anchor_bottom = parentVector.y
	
	self.offset_left = myOffsets.position.x
	self.offset_right = myOffsets.end.x
	self.offset_top = myOffsets.position.y
	self.offset_bottom = myOffsets.end.y

func MoveToAnchorPosition(myAnchor:Control.LayoutPreset, parentAnchor:Control.LayoutPreset, 
		offset:Vector2, duration:float, trans:Tween.TransitionType=Tween.TRANS_LINEAR,
		anchorEase:Tween.EaseType=Tween.EASE_IN_OUT):
			
	var parentVector:Vector2 = GetParentAnchor(parentAnchor)
	var myOffsets:Rect2 = GetMyOffsets(myAnchor, offset)
	
	var tween = create_tween()
	tween.set_trans(trans).set_ease(anchorEase).set_parallel(true)
	
	tween.tween_property(self, "anchor_left", parentVector.x, duration)
	tween.tween_property(self, "anchor_right", parentVector.x, duration)
	tween.tween_property(self, "anchor_top", parentVector.y, duration)
	tween.tween_property(self, "anchor_bottom", parentVector.y, duration)
		
	tween.tween_property(self, "offset_left", myOffsets.position.x, duration)
	tween.tween_property(self, "offset_right", myOffsets.end.x, duration)
	tween.tween_property(self, "offset_top", myOffsets.position.y, duration)
	tween.tween_property(self, "offset_bottom", myOffsets.end.y, duration)
	
	await tween.finished

func ToAnochorPosition(anchor:PanelAnchor,animated:bool):
	if animated:
		MoveToAnchorPosition(anchor.myAnchor, anchor.parentAnchor, anchor.offset, anchor.duration, anchor.trans, anchor.anchorEase)
	else:
		SnapToAnchorPosition(anchor.myAnchor, anchor.parentAnchor, anchor.offset)
