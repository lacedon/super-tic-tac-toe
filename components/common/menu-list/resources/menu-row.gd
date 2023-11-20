extends Resource
class_name MenuRow

const MenuList = preload('./menu.gd')

func createRow(_menu: MenuList, _parent: Control) -> Control:
	return Control.new()
