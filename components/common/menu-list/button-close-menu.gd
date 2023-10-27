extends Button

@export var menu: Node
@export var parentMenu: Node
@export var previousMenu: MenuList

func _enter_tree():
	connect("pressed", closeMenu)

func _exit_tree():
	disconnect("pressed", closeMenu)

func closeMenu():
	parentMenu.remove_child(menu)
	previousMenu.show()
