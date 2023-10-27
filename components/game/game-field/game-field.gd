extends Control
class_name TTT_Game_Field

const TTT_Cell: Resource = preload("res://components/game/cell/cell.gd")

const _offset: int = uiSettings.gameFieldOffset
const _lineWidth: int = uiSettings.gameFieldLineWidth

const lineCoordinates: Array[Vector4] = [
	Vector4(1, 0, 1, 3),
	Vector4(2, 0, 2, 3),
	Vector4(0, 1, 3, 1),
	Vector4(0, 2, 3, 2),
]

@export var parentIndex: int = TTT_State.mainFieldIndex
@export var state: TTT_State
@export var cellSize: int = uiSettings.cellSize
@export var hasOffset: bool = true

func _ready():
	var index: = 0
	for x in range(gameSettings.cellNumber):
		for y in range(gameSettings.cellNumber):
			var cell = _createCell(x, y, index)
			index += 1
			add_child(cell)

	for lineVector in lineCoordinates:
		var line = _initFieldLines(lineVector)
		add_child(line)

func _createCell(x: int, y: int, index: int) -> TTT_Cell:
	var halfCellSize: int = roundi(float(cellSize) / 2)
	var cell: TTT_Cell = TTT_Cell.new()
	cell.name = "Cell[" + str(x) + "," + str(y) + "]"
	cell.state = state
	cell.index = index
	cell.cellSize = cellSize
	cell.parentIndex = parentIndex
	cell.position.x = x * cellSize + halfCellSize
	cell.position.y = y * cellSize + halfCellSize

	return cell

func _initFieldLines(pointDescriptions: Vector4) -> Line2D:
	var isHorizontal: bool = pointDescriptions.x == pointDescriptions.z

	var line: Line2D = Line2D.new()
	line.name = ("Vertical" if isHorizontal else "Horizontal") + "Line" + str(pointDescriptions.x if isHorizontal else pointDescriptions.y)

	line.width = _lineWidth
	line.default_color = uiSettings.lineColor
	line.joint_mode = Line2D.LINE_JOINT_ROUND
	line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	line.end_cap_mode = Line2D.LINE_CAP_ROUND

	var points: PackedVector2Array = []
	var pointNumber: int = abs(pointDescriptions.y - pointDescriptions.w) if isHorizontal else abs(pointDescriptions.x - pointDescriptions.z)

	for coordinate in range(pointNumber + 1):
		var x: float = pointDescriptions.x if isHorizontal else float(coordinate)
		var y: float = pointDescriptions.y if !isHorizontal else float(coordinate)
		var coordinateOffset: int = int(_offset if hasOffset else 0) if coordinate == 0 || coordinate == size else 0
		var offsetFactor: int = 1 if coordinate == 0 else TTT_State.mainFieldIndex

		points.append(Vector2(
			x * cellSize + (1 if isHorizontal else coordinateOffset * offsetFactor),
			y * cellSize + (coordinateOffset * offsetFactor if isHorizontal else 1),
		))
	line.points = points

	line.gradient = uiSettings.lineGradient

	return line
