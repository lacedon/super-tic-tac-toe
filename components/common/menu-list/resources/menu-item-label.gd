extends MenuItem
class_name MenuItemLabel

@export var text: String

func _init(
	initProps: Dictionary = props,
	initText: String = text,
):
	text = initText
	props = initProps

func createItem(_menu: MenuList) -> Control:
	var label = Label.new()
	label.text = text

	if props:
		for propName in props:
			label[propName] = props[propName]

	return label