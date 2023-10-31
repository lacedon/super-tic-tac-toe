const MenuRow = preload('./resources/menu-row.gd')
const ConfigParser = preload('./config-parser.gd');

static func createRow(rowConfig: MenuRow, index: int, menu: MenuList, parentNode: Node, previousMenu: MenuList) -> MarginContainer:
	var horizontalContainer = HBoxContainer.new()
	horizontalContainer.name = 'RowContainer'

	match rowConfig.aligment:
		MenuRow.MenuRowAligment.begin:
			horizontalContainer.alignment = BoxContainer.ALIGNMENT_BEGIN
		MenuRow.MenuRowAligment.end:
			horizontalContainer.alignment = BoxContainer.ALIGNMENT_END
		_:
			horizontalContainer.alignment = BoxContainer.ALIGNMENT_CENTER

	for item in rowConfig.items:
		horizontalContainer.add_child(ConfigParser.createNodeFromConfig(item, menu, parentNode, previousMenu))

	var marginContainer = MarginContainer.new()
	marginContainer.name = 'Row #' + str(index)
	marginContainer.add_theme_constant_override('margin_left', 0)
	marginContainer.add_theme_constant_override('margin_right', 0)
	marginContainer.add_theme_constant_override('margin_top', 16)
	marginContainer.add_theme_constant_override('margin_bottom', 0)
	marginContainer.add_child(horizontalContainer)

	if rowConfig.type == MenuRow.MenuRowType.spacer:
		marginContainer.size_flags_vertical = Control.SIZE_EXPAND

	return marginContainer
