@tool

extends MenuItem
class_name MenuItemTitle

@export var text: String

func _init(
	initProps: Dictionary = props,
	initText: String = text,
):
	text = initText
	props = initProps

func createItem(_menuGenerator: MenuGenerator) -> Control:
	var title = Label.new()
	title.add_theme_font_size_override('font_size', 80)

	title.text = text

	if props:
		for propName in props:
			title[propName] = props[propName]

	return title