extends MenuRow
class_name MenuRowSpacer

func createRow(_menu: MenuList, parent: Control) -> Control:
	parent.size_flags_vertical = Control.SIZE_EXPAND
	return Control.new()
