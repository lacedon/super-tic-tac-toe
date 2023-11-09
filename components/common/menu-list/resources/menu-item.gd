extends Resource
class_name MenuItem

const Menu = preload('./menu.gd')

enum MenuItemType {
	title,
	button,
	innerMenu,
	closeMenu,
	spacer,
	label,
}

@export var type: MenuItemType = MenuItemType.button
@export var text: String
@export var styles: Dictionary
@export var props: Dictionary
@export var size: Vector2 = Vector2.ZERO
@export var scriptPath: GDScript
@export var innerMenu: Menu

func _init(
	initType: MenuItemType = type,
	initText: String = text,
	initStyles: Dictionary = styles,
	initProps: Dictionary = props,
	initSize: Vector2 = size,
	initScriptPath: GDScript = scriptPath,
	initInnerMenu: Menu = innerMenu,
):
	type = initType
	text = initText
	styles = initStyles
	props = initProps
	size = initSize
	scriptPath = initScriptPath
	innerMenu = initInnerMenu
