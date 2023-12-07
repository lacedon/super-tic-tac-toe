@tool

extends Resource
class_name MenuRow

func createRow(_menuGenerator: MenuGenerator, _parent: Control) -> Control:
	return Control.new()
