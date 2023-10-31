extends VBoxContainer
class_name MenuList

const Menu = preload('./resources/menu.gd')
const MenuRow = preload('./resources/menu-row.gd')
const MenuItem = preload('./resources/menu-item.gd')
const ButtonStyler = preload("res://components/common/button-styler.gd")
const RowCreator = preload('./row-creator.gd');

@export var menu: Menu
@export var parentMenu: Node
@export var previousMenu: MenuList

func _enter_tree():
	_applyMenuConfig()

func _createRow(rowConfig: MenuRow, index: int):
	return RowCreator.createRow(rowConfig, index, self, parentMenu, previousMenu)

func _applyMenuConfig():
	if !menu: return

	var index = 1
	for rowConfig in menu.rows:
		add_child(_createRow(rowConfig, index))
		index += 1

	if menu.closable:
		add_child(_createRow(MenuRow.new(MenuRow.MenuRowType.itemList, MenuRow.MenuRowAligment.end, [
			MenuItem.new(MenuItem.MenuItemType.closeMenu, 'Back', { direction = 3, mode = 2 })
		]), index))
		index += 1
