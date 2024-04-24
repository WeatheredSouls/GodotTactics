extends Node

@export var childPanel: LayoutAnchor
@export var vbox: VBoxContainer
@export var animated: bool

@export var anchorList:Array[PanelAnchor] = []

func GetAnchor(anchorName: String):
	for anchor in self.anchorList:
		if anchor.anchorName == anchorName:
			return anchor
	return null

func AnchorButton(text:String):
	var anchor = GetAnchor(text)
	if anchor:
		childPanel.ToAnochorPosition(anchor, animated)
	else:
		print("Anchor is null")

func _ready():
	#Buttons
	var buttonShow = Button.new()
	buttonShow.text = "Show"
	buttonShow.pressed.connect(AnchorButton.bind("Show"))
	vbox.add_child(buttonShow)
	
	var buttonHide = Button.new()
	buttonHide.text = "Hide"
	buttonHide.pressed.connect(AnchorButton.bind("Hide"))
	vbox.add_child(buttonHide)
	
	var buttonCenter = Button.new()
	buttonCenter.text = "Center"
	buttonCenter.pressed.connect(AnchorButton.bind("Center"))
	vbox.add_child(buttonCenter)
	
	#Add new anchor to list
	var anchorCenter:PanelAnchor = PanelAnchor.new()
	anchorCenter.SetValues("Center",Control.PRESET_CENTER, Control.PRESET_CENTER, Vector2.ZERO, .5, Tween.TRANS_BACK )
	anchorList.append(anchorCenter)
