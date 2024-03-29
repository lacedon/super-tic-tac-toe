extends Button

@export var menu: Menu
@export var parentMenu: Node
@export var previousMenu: MenuGenerator

func _enter_tree():
	connect(pressed.get_name(), _onClick)

func _exit_tree():
	disconnect(pressed.get_name(), _onClick)

func _onClick():
	previousMenu.hide()

	var childMenu = MenuGenerator.new()
	childMenu.menu = menu
	childMenu.parentMenu = parentMenu
	childMenu.previousMenu = previousMenu
	childMenu.layout_mode = 1
	childMenu.anchors_preset = PRESET_FULL_RECT

	parentMenu.add_child(childMenu)
