@tool

extends MenuItem
class_name MenuItemButton

const ButtonSound = preload("res://components/common/button-sound.gd")

@export var text: String
@export var styles: Dictionary
@export var scriptPath: GDScript

func _init(
	initProps: Dictionary = props,
	initText: String = text,
	initStyles: Dictionary = styles,
	initScriptPath: GDScript = scriptPath,
):
	text = initText
	styles = initStyles
	props = initProps
	scriptPath = initScriptPath

func createItem(menuGenerator: MenuGenerator) -> Control:
	var button = Button.new()
	button.text = text
	if scriptPath:
		button.set_script(scriptPath)

	if props:
		for propName in props:
			button[propName] = props[propName]

	if styles:
		var buttonThemable = ButtonStyler.new()
		buttonThemable.mode = styles.mode
		buttonThemable.direction = styles.direction
		button.add_child(buttonThemable)

	var buttonSound = ButtonSound.new()
	buttonSound.downSound = menuGenerator.buttonDownSound
	button.add_child(buttonSound)

	return button