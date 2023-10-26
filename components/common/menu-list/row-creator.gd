static func createRow(rowConfig: Dictionary, contentItems: Array[Node]) -> MarginContainer:
	var horizontalContainer = HBoxContainer.new()

	if 'aligment' in rowConfig:
		match rowConfig.aligment:
			'begin':
				horizontalContainer.alignment = BoxContainer.ALIGNMENT_BEGIN
			'end':
				horizontalContainer.alignment = BoxContainer.ALIGNMENT_END
			_:
				horizontalContainer.alignment = BoxContainer.ALIGNMENT_CENTER
	else:
		horizontalContainer.alignment = BoxContainer.ALIGNMENT_CENTER

	for content in contentItems:
		horizontalContainer.add_child(content)

	var marginContainer = MarginContainer.new()
	marginContainer.add_theme_constant_override('margin_left', 0)
	marginContainer.add_theme_constant_override('margin_right', 0)
	marginContainer.add_theme_constant_override('margin_top', 16)
	marginContainer.add_theme_constant_override('margin_bottom', 0)
	marginContainer.add_child(horizontalContainer)

	if "type" in rowConfig && rowConfig.type == "expand":
		marginContainer.size_flags_vertical = Control.SIZE_EXPAND

	return marginContainer
