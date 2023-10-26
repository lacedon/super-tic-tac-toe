extends Control

const _offset: int = uiSettings.signOffset
const _doubleOffset: int = 2 * _offset

@export var value: TTT_State.FieldType
@export var cellSize: int = uiSettings.cellSize
@export var centererByX: bool = false

func _draw():
	if value == TTT_State.FieldType.o: _drawO()
	else: _drawX()

func _drawO():
	var halfCellSize: int = roundi(float(cellSize) / 2)
	var width: int = roundi(float(cellSize) / 10)

	draw_arc(Vector2(halfCellSize - (halfCellSize if centererByX else 0), halfCellSize), halfCellSize - _doubleOffset, 0, TAU, 40, uiSettings.playerOColor, width)

func _drawX():
	var halfCellSize: int = roundi(float(cellSize) / 2)
	var width: int = roundi(float(cellSize) / 10)

	draw_arc(Vector2(cellSize - _doubleOffset - (halfCellSize if centererByX else 0), halfCellSize), halfCellSize - _doubleOffset, 0.25 * TAU, 0.75 * TAU, 40, uiSettings.playerXColor, width, true)
	draw_arc(Vector2(_doubleOffset - (halfCellSize if centererByX else 0), halfCellSize), halfCellSize - _doubleOffset, 0.75 * TAU, 1.25 * TAU, 40, uiSettings.playerXColor, width, true)
