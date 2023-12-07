@tool

extends Resource
class_name Menu

@export var rows: Array[MenuRow] = []

func _init(initRows: Array[MenuRow] = rows):
	rows = initRows
