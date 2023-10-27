extends VBoxContainer
class_name MenuList

const ButtonStyler = preload("res://components/common/button-styler.gd")
const ConfigParser = preload('./config-parser.gd');
const RowCreator = preload('./row-creator.gd');

@export var list: Resource
@export var listJSON: Dictionary
@export var closable: bool = false
@export var parentMenu: Node
@export var previousMenu: MenuList

func _enter_tree():
	_applyMenuConfig()

func _getMenuConfig() -> Dictionary:
	if listJSON: return listJSON
	if list: return list.get('data')
	return { menuItems = [] }

func _createRowFromConfig(rowConfig: Dictionary):
	var children: Array[Node] = []
	if 'items' in rowConfig:
		for item in rowConfig.items:
			children.append(ConfigParser.createNodeFromConfig(item, self, parentMenu, previousMenu))
	return RowCreator.createRow(rowConfig, children)

func _applyMenuConfig():
	var menuConfig = _getMenuConfig()
	for rowConfig in menuConfig.rows:
		add_child(_createRowFromConfig(rowConfig))
	if closable:
		add_child(_createRowFromConfig({
			aligment = "end",
			items = [{ type = 'closeMenu', text = 'Back', styles = { direction = 3, mode = 2 } }]
		}))
