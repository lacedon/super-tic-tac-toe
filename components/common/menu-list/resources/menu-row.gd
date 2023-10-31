extends Resource
class_name MenuRow

const MenuItem = preload('./menu-item.gd')

enum MenuRowType {
	itemList,
	spacer,
}

enum MenuRowAligment {
	begin,
	center,
	end,
}

@export var type: MenuRowType = MenuRowType.itemList
@export var aligment: MenuRowAligment = MenuRowAligment.begin
@export var items: Array[MenuItem] = []

func _init(
	initType: MenuRowType = type,
	initAligment: MenuRowAligment = aligment,
	initItems: Array[MenuItem] = items,
):
	type = initType
	aligment = initAligment
	items = initItems
