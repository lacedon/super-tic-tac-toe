extends Control
class_name TTT_MenuList

const _buttonNormalStyles = preload('res://themes/button-styles-normal.tres')
const _buttonHoverStyles = preload('res://themes/button-styles-hover.tres')
const _buttonPressedStyles = preload('res://themes/button-styles-pressed.tres')
const TTTButton = preload("res://components/game/button/button.gd")
const ExtendMenuButton = preload('./extend-menu-button.gd')
const CloseMenuButton = preload('./close-menu.gd')

@export var list: Resource
@export var listJSON: Dictionary
@export var closable: bool = false
@export var fullRect: bool = false
@export var parentMenu: Node

func _ready():
	if fullRect:
		anchors_preset = PRESET_FULL_RECT
	else:
		anchors_preset = PRESET_CENTER

	var menuConfig = _getMenuConfig()

	var background = Panel.new()
	background.layout_mode = 1
	background.anchors_preset = PRESET_FULL_RECT
	add_child(background)

	var container: = _createContainer()
	for menuItem in menuConfig.menuItems:
		container.add_child(_createLine(_createLineContent(menuItem)))

	if closable:
		container.add_child(_createLine(_createLineContent({ type = 'space' })))
		container.add_child(_createLine(_createLineContent({
			type = 'closeMenu',
			text = 'Close',
		})))

	add_child(container)

func _getMenuConfig() -> Dictionary:
	if listJSON: return listJSON
	if list: return list.get('data')
	return { menuItems = [] }

func _createContainer() -> VBoxContainer:
	var vBox = VBoxContainer.new()
	vBox.alignment = BoxContainer.ALIGNMENT_CENTER
	vBox.layout_mode = 1
	vBox.anchors_preset = PRESET_FULL_RECT
	return vBox

func _createLine(content: Node) -> MarginContainer:
	var horizontalContainer = HBoxContainer.new()
	horizontalContainer.alignment = BoxContainer.ALIGNMENT_CENTER
	horizontalContainer.add_child(content)

	var marginContainer = MarginContainer.new()
	marginContainer.add_theme_constant_override('margin_left', 16)
	marginContainer.add_theme_constant_override('margin_right', 16)
	marginContainer.add_theme_constant_override('margin_top', 8)
	marginContainer.add_theme_constant_override('margin_bottom', 8)
	marginContainer.add_child(horizontalContainer)

	return marginContainer

func _createLineContent(config) -> Node:
	match config.type:
		'title':
			var label = Label.new()
			label.text = config.text
			return label
		'button':
			var button = TTTButton.new()
			button.text = config.text
			if 'size' in config:
				button.custom_minimum_size = Vector2(
					config.size[0] if config.size.size() > 1 && config.size[0] else 0,
					config.size[1] if config.size.size() > 2 && config.size[1] else 0,
				)
			if 'script' in config:
				button.set_script(load(config.script))
			if 'props' in config:
				for propName in config.props:
					button[propName] = config.props[propName]
			return button
		'innerMenu':
			var button = ExtendMenuButton.new()
			button.text = config.text
			button.menuJSON = config.innerMenu
			button.parentMenu = parentMenu

			return button
		'closeMenu':
			var button = CloseMenuButton.new()
			button.text = config.text
			button.menu = self
			button.parentMenu = parentMenu

			return button
	return Node.new()
