@tool

extends MenuItem
class_name MenuItemSpacer

func createItem(_menuGenerator: MenuGenerator) -> Control:
	var spacer = VSplitContainer.new()
	spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	return spacer
