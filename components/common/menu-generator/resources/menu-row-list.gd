@tool

extends MenuRow
class_name MenuRowList

const MenuItem = preload('./menu-item.gd')

enum MenuRowAligment {
	begin,
	center,
	end,
}

@export var aligment: MenuRowAligment = MenuRowAligment.begin
@export var items: Array[MenuItem] = []

func _init(
	initAligment: MenuRowAligment = aligment,
	initItems: Array[MenuItem] = items,
):
	aligment = initAligment
	items = initItems

func createRow(menuGenerator: MenuGenerator, _parent: Control) -> Control:
	var horizontalContainer = HBoxContainer.new()
	horizontalContainer.name = 'RowContainer'

	match aligment:
		MenuRowList.MenuRowAligment.begin:
			horizontalContainer.alignment = BoxContainer.ALIGNMENT_BEGIN
		MenuRowList.MenuRowAligment.end:
			horizontalContainer.alignment = BoxContainer.ALIGNMENT_END
		_:
			horizontalContainer.alignment = BoxContainer.ALIGNMENT_CENTER

	for item in items:
		horizontalContainer.add_child(item.createItem(menuGenerator))

	return horizontalContainer
