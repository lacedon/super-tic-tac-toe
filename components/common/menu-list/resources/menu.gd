extends Resource
class_name Menu

const MenuRow = preload('./menu-row.gd')

@export var closable: bool = false
@export var rows: Array[MenuRow] = []

func _init(
	initClosable: bool = closable,
	initRows: Array[MenuRow] = rows,
):
	closable = initClosable
	rows = initRows
