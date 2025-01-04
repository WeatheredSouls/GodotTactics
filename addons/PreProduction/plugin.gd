@tool
extends EditorPlugin

var panel
const Tool_Panel = preload("res://addons/PreProduction/Pre Production.tscn")


func _enter_tree():	
	panel = Tool_Panel.instantiate()	
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_UR, panel)

func _exit_tree():
	remove_control_from_docks(panel)
	panel.queue_free()
