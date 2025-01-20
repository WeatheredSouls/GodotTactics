extends Node
class_name StatPanelController

const ShowKey:String = "Show"
const HideKey:String = "Hide"

@export var primaryPanel:StatPanel
@export var secondaryPanel:StatPanel

var primaryShowing:bool
var secondaryShowing:bool

func _ready():
	primaryPanel.ToAnochorPosition(primaryPanel.GetAnchor(HideKey), false)
	primaryShowing = false
	secondaryPanel.ToAnochorPosition(secondaryPanel.GetAnchor(HideKey), false)
	secondaryShowing = false
	
func ShowPrimary(obj:Node):
	primaryPanel.Display(obj)
	if primaryShowing == false:
		primaryShowing = true
		await primaryPanel.SetPosition(ShowKey,true)
	
func HidePrimary():
	if primaryShowing == true:
		primaryShowing = false
		await primaryPanel.SetPosition(HideKey,true)

func ShowSecondary(obj:Node):
	secondaryPanel.Display(obj)
	if secondaryShowing == false:
		secondaryShowing = true
		await secondaryPanel.SetPosition(ShowKey,true)
	
func HideSecondary():
	if secondaryShowing == true:
		secondaryShowing = false
		await secondaryPanel.SetPosition(HideKey,true)
