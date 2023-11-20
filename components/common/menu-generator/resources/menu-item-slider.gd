@tool

extends MenuItem
class_name MenuItemSlider

@export var text: String
@export var defaultValue: int
@export var minValue: float = 0
@export var maxValue: float = 100
@export var sliderScript: GDScript
@export var labelProps: Dictionary

func _init(
	initProps: Dictionary = props,
	initText: String = text,
	initDefaultValue: int = defaultValue,
	initMin: float = minValue,
	initMax: float = maxValue,
	initLabelProps: Dictionary = labelProps,
):
	text = initText
	props = initProps
	defaultValue = initDefaultValue
	minValue = initMin
	maxValue = initMax
	labelProps = initLabelProps

func createItem(_menuGenerator: MenuGenerator) -> Control:
	var container = HBoxContainer.new()
	container.name = 'Slider container'

	var label = Label.new()
	label.text = text
	label.add_theme_font_size_override('font_size', 48)

	if props:
		for propName in labelProps:
			label[propName] = labelProps[propName]

	container.add_child(label)

	var slider = HSlider.new()
	slider.value = defaultValue
	slider.min_value = minValue
	slider.max_value = maxValue
	slider.set_script(sliderScript)

	if props:
		for propName in props:
			slider[propName] = props[propName]

	container.add_child(slider)

	return container
