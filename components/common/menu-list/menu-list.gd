extends Control
class_name MenuList

const ButtonStyler = preload("res://components/common/button-styler.gd")
const MenuContainer = preload('./menu-container.gd');
const ConfigParser = preload('./config-parser.gd');
const RowCreator = preload('./row-creator.gd');

@export var list: Resource
@export var listJSON: Dictionary
@export var closable: bool = false
@export var fullRect: bool = false
@export var parentMenu: Node

func _enter_tree():
	# _applyPreset()
	add_child(_createBackground())
	add_child(_applyMenuContainer())

func _applyPreset():
	if fullRect:
		anchors_preset = PRESET_FULL_RECT
	else:
		anchors_preset = PRESET_CENTER

func _createBackground():
	var background = Panel.new()
	background.layout_mode = 1
	background.anchors_preset = PRESET_FULL_RECT
	return background

func _getMenuConfig() -> Dictionary:
	if listJSON: return listJSON
	if list: return list.get('data')
	return { menuItems = [] }

func _createRowFromConfig(rowConfig: Dictionary):
	var children: Array[Node] = []
	if 'items' in rowConfig:
		for item in rowConfig.items:
			children.append(ConfigParser.createNodeFromConfig(item, self, parentMenu))
	return RowCreator.createRow(rowConfig, children)

func _applyMenuContainer():
	var container: = MenuContainer.new()
	var menuConfig = _getMenuConfig()
	for rowConfig in menuConfig.rows:
		container.add_child(_createRowFromConfig(rowConfig))
	if closable:
		container.add_child(_createRowFromConfig({
			aligment = "end",
			items = [{ type = 'closeMenu', text = 'Back', styles = { direction = 3, mode = 2 } }]
		}))
	return container
