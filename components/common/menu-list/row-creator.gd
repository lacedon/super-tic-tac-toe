static func createRow(contentItems: Array[Node]) -> MarginContainer:
	var horizontalContainer = HBoxContainer.new()
	horizontalContainer.alignment = BoxContainer.ALIGNMENT_CENTER

	for content in contentItems:
		horizontalContainer.add_child(content)

	var marginContainer = MarginContainer.new()
	marginContainer.add_theme_constant_override('margin_left', 16)
	marginContainer.add_theme_constant_override('margin_right', 16)
	marginContainer.add_theme_constant_override('margin_top', 8)
	marginContainer.add_theme_constant_override('margin_bottom', 8)
	marginContainer.add_child(horizontalContainer)

	return marginContainer
