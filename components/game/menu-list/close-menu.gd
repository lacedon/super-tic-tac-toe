extends Button

@export var menu: Node
@export var parentMenu: Node

func _enter_tree():
	connect("pressed", closeMenu)

func _exit_tree():
	disconnect("pressed", closeMenu)

func closeMenu():
	parentMenu.remove_child(menu)
