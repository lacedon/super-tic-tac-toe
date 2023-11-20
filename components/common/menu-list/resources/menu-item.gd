extends Resource
class_name MenuItem

const MenuList = preload('./menu.gd')

@export var props: Dictionary

func _init(initProps: Dictionary = props):
	props = initProps

func createItem(_menu: MenuList) -> Control:
	return Control.new()
