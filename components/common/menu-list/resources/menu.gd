extends Resource
class_name Menu

const MenuRow = preload('./menu-row-list.gd')

@export var rows: Array[MenuRow] = []

func _init(initRows: Array[MenuRow] = rows):
	rows = initRows
