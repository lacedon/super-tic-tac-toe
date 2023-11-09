extends Node
class_name ButtonStyler

enum ButtonMode {
	none,
	main,
	second,
	first,
}

enum ButtonDirection {
	none,
	full,
	left,
	right,
}

enum ButtonState {
	normal,
	hover,
	pressed,
}

@export var mode: ButtonMode
@export var direction: ButtonDirection
@export var style: String

func _enter_tree():
	_applyOverride(ButtonState.normal)
	_applyOverride(ButtonState.hover)
	_applyOverride(ButtonState.pressed)

func _applyOverride(state: ButtonState):
	if (
		!style && (
		mode == ButtonMode.none ||
		direction == ButtonDirection.none
	)):
			return

	var modeString: String = ButtonMode.keys()[mode]
	var directionString: String = ButtonDirection.keys()[direction]
	var stateString: String = ButtonState.keys()[state]
	var folderName: String = style if style else (modeString + '-' + directionString)

	var stylePressedPath: String = 'res://themes/button-styles/' + folderName + '/' + stateString + '.tres'
	var stylePressed: StyleBox = load(stylePressedPath)

	if !stylePressed: return

	var parent: Button = self.get_parent()

	parent.add_theme_stylebox_override(stateString, stylePressed)

	if stylePressed.has_meta('color'):
		var fontColor = stylePressed.get_meta('color')
		parent.add_theme_color_override("font_color", fontColor)
		parent.add_theme_color_override("font_pressed_color", fontColor)
		parent.add_theme_color_override("font_hover_color", fontColor)
		parent.add_theme_color_override("font_focus_color", fontColor)
		parent.add_theme_color_override("font_hover_pressed_color", fontColor)
		parent.add_theme_color_override("font_disabled_color", fontColor)
