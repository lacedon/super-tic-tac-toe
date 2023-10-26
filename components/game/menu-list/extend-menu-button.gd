extends Button
class_name TTT_ExtendMenuButton

@export var menuJSON: Dictionary
@export var parentMenu: Node

func _enter_tree():
	connect("pressed", _onClick)

func _exit_tree():
	disconnect("pressed", _onClick)

func _onClick():
	var childMenu = TTT_MenuList.new()
	childMenu.listJSON = menuJSON
	childMenu.closable = true
	childMenu.fullRect = true
	childMenu.parentMenu = parentMenu
	childMenu.layout_mode = 1
	childMenu.anchors_preset = PRESET_FULL_RECT

	parentMenu.add_child(childMenu)
