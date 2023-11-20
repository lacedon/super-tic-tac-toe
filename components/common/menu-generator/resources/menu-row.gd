@tool

extends Resource
class_name MenuRow

const MenuGenerator = preload('../menu-generator.gd')

func createRow(_menuGenerator: MenuGenerator, _parent: Control) -> Control:
	return Control.new()
