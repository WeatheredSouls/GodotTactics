extends Node
class_name HitSuccessIndicator

signal AutomaticHitCheckNotification
signal AutomaticMissCheckNotification
signal StatusCheckNotification

signal MissedNotification
signal HitNotification

@export var anchorList:Array[PanelAnchor] = []
@export var panel:LayoutAnchor
@export var arrow:TextureProgressBar
@export var label:Label

func _ready():
	SetPosition("Hide", false)

func SetStats(chance:int, amount:int):
	arrow.value = chance
	label.text = "{0}% {1}pt(s)".format([chance, amount])
	
func Show():
	SetPosition("Show", true)

func Hide():
	SetPosition("Hide", true)

func SetPosition(anchorName:String, animated:bool):
	var anchor = GetAnchor(anchorName)
	await panel.ToAnochorPosition(anchor, animated)	
	
func GetAnchor(anchorName: String):
	for anchor in self.anchorList:
		if anchor.anchorName == anchorName:
			return anchor
	return null
