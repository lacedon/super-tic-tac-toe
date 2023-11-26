extends Button

@export var menu: Node
@export var parentMenu: Node
@export var previousMenu: MenuGenerator

func _enter_tree():
	connect(pressed.get_name(), closeMenu)

func _exit_tree():
	disconnect(pressed.get_name(), closeMenu)

func closeMenu():
	parentMenu.remove_child(menu)
	previousMenu.show()
