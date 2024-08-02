extends Node
class_name AbilityMenuPanelController

const ShowKey:String = "Show"
const HideKey:String = "Hide"
const EntryPoolKey:String = "AbilityMenuPanel.Entry"
const MenuCount:int = 4

@export var entryPrefab:PackedScene
@export var titleLabel:Label
@export var panel:AbilityMenuPanel
@export var entryVbox:VBoxContainer
var menuEntries: Array[AbilityMenuEntry] = []
var selection:int

func _ready():
	%PoolController.AddEntry(EntryPoolKey, entryPrefab, MenuCount, 2147483647)
	panel.SetPosition(HideKey, false)
	_DisableNode(panel)

func _DisableNode(node:Node) -> void:
	node.process_mode = Node.PROCESS_MODE_DISABLED
	node.hide()

func _EnableNode(node:Node) -> void:
	node.process_mode = Node.PROCESS_MODE_INHERIT
	node.show()

func Show(title:String, options:Array[String]):
	_EnableNode(panel)
	Clear()
	titleLabel.text = tr(title)
	for option in options:
		var entry:AbilityMenuEntry = Dequeue()
		entry.Title = tr(option)
		menuEntries.append(entry)
	SetSelection(0)
	await panel.SetPosition(ShowKey, true)

func Hide():
	await panel.SetPosition(HideKey, true)
	Clear()
	
	#force panel to shink before fitting to the correct size
	panel.size = Vector2(0,0)
	panel.SetPosition(HideKey, false)
	
	_DisableNode(panel)

func SetLocked(index:int, value:bool):
	if( index < 0 || index >= menuEntries.size()):
		return
	
	menuEntries[index].IsLocked = value
	if (value && selection == index):
		Next()

func Next():
	if menuEntries.size() == 0:
		return
	for i in range(selection + 1, menuEntries.size() +2):
		var index:int = i % menuEntries.size()
		if SetSelection(index):
			break

func Previous():
	if menuEntries.size() == 0:
		return
	for i in range(selection - 1 + menuEntries.size(), selection, -1):
		var index:int = i % menuEntries.size()
		if SetSelection(index):
			break

func Dequeue()->AbilityMenuEntry:
	var p:Poolable = %PoolController.Dequeue(EntryPoolKey)
	var entry:AbilityMenuEntry = p.get_node("Entry")
	
	if(p.get_parent()):
		p.get_parent().remove_child(p)
	entryVbox.add_child(p)
	_EnableNode(p)
	entry.Reset()
	return entry

func Enqueue(entry:AbilityMenuEntry):
	var p:Poolable = entry.get_parent()
	%PoolController.Enqueue(p)

func Clear():
	for i in range(menuEntries.size()-1, -1, -1):
		Enqueue(menuEntries[i])
	menuEntries.clear()

func SetSelection(value:int)->bool:
	if menuEntries[value].IsLocked:
		return false
	
	#Deselect the previously selected entry
	if (selection >= 0 && selection < menuEntries.size()):
		menuEntries[selection].IsSelected = false
	
	selection = value
	
	#Select the new entry
	if(selection >= 0 && selection < menuEntries.size()):
		menuEntries[selection].IsSelected = true
	
	return true
