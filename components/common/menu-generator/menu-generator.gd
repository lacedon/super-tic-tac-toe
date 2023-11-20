@tool

extends VBoxContainer
class_name MenuGenerator

const buttonDownSound = preload("res://assets/button-noise.mp3")
const Menu = preload('./resources/menu.gd')

@export var menu: Menu

func _enter_tree():
	_applyMenuConfig()

func _createRow(rowConfig: MenuRow, index: int):
	var marginContainer = MarginContainer.new()
	marginContainer.name = 'Row #' + str(index)
	marginContainer.add_theme_constant_override('margin_left', 0)
	marginContainer.add_theme_constant_override('margin_right', 0)
	marginContainer.add_theme_constant_override('margin_top', 16)
	marginContainer.add_theme_constant_override('margin_bottom', 0)

	marginContainer.add_child(rowConfig.createRow(self, marginContainer))

	return marginContainer

func _applyMenuConfig():
	if !menu: return

	# Clear previous children
	for child in self.get_children():
		child.queue_free()

	var index = 1
	for rowConfig in menu.rows:
		add_child(_createRow(rowConfig, index))
		index += 1
