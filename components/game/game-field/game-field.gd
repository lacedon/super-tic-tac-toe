extends Control
class_name TTT_Game_Field

const TTT_Cell: Resource = preload("res://components/game/cell/cell.gd")

const _offset: int = gameSettings.gameFieldOffset
const _lineWidth: int = gameSettings.gameFieldLineWidth

const lineCoordinates: Array[Vector4] = [
	Vector4(1, 0, 1, 3),
	Vector4(2, 0, 2, 3),
	Vector4(0, 1, 3, 1),
	Vector4(0, 2, 3, 2),
]

@export var parentIndex: int = TTT_State.mainFieldIndex
@export var state: TTT_State
@export var cellSize: int = gameSettings.cellSize
@export var hasOffset: bool = true
var _lines: Array[Line2D] = []
var cells: Array[TTT_Cell] = []

func _init(
	initState: TTT_State = state,
	initCellSize: int = cellSize,
	initParentIndex: int = parentIndex,
	initHasOffset: bool = hasOffset,
):
	state = initState
	cellSize = initCellSize
	parentIndex = initParentIndex
	hasOffset = initHasOffset

func _ready():
	cells.clear()
	var index: = 0
	for x in range(gameSettings.cellNumber):
		for y in range(gameSettings.cellNumber):
			var cell = _createCell(x, y, index)
			index += 1
			add_child(cell)
			cells.append(cell)

	for lineVector in lineCoordinates:
		var line = _initFieldLines(lineVector)
		_lines.append(line)
		add_child(line)

func _enter_tree():
	state.connect(state.openBlockChanged.get_name(), _toggleActive)
	state.connect(state.restart.get_name(), _handleRestart)

func _exit_tree():
	state.disconnect(state.openBlockChanged.get_name(), _toggleActive)
	state.disconnect(state.restart.get_name(), _handleRestart)

func _handleRestart():
	_toggleActive(TTT_State.mainFieldIndex)

func _toggleActive(openBlock: int):
	var isActive = openBlock == parentIndex
	for line in _lines:
		line.default_color = gameSettings.lineColorActive if isActive else gameSettings.lineColor

func _createCell(x: int, y: int, index: int) -> TTT_Cell:
	var halfCellSize: int = roundi(float(cellSize) / 2)
	var cell: TTT_Cell = TTT_Cell.new(state, cellSize, index, parentIndex)
	cell.name = "Cell[" + str(x) + "," + str(y) + "]"
	cell.position.x = x * cellSize + halfCellSize
	cell.position.y = y * cellSize + halfCellSize

	return cell

func _initFieldLines(pointDescriptions: Vector4) -> Line2D:
	var isActive = TTT_State_Selectors.getOpenBlock(state) == parentIndex
	var isHorizontal: bool = pointDescriptions.x == pointDescriptions.z

	var line: Line2D = Line2D.new()
	line.name = ("Vertical" if isHorizontal else "Horizontal") + "Line" + str(pointDescriptions.x if isHorizontal else pointDescriptions.y)

	line.width = _lineWidth
	line.default_color = gameSettings.lineColorActive if isActive else gameSettings.lineColor
	line.joint_mode = Line2D.LINE_JOINT_ROUND
	line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	line.end_cap_mode = Line2D.LINE_CAP_ROUND

	var points: PackedVector2Array = []
	var pointNumber: int = abs(pointDescriptions.y - pointDescriptions.w) if isHorizontal else abs(pointDescriptions.x - pointDescriptions.z)

	for coordinate in range(pointNumber + 1):
		var x: float = pointDescriptions.x if isHorizontal else float(coordinate)
		var y: float = pointDescriptions.y if !isHorizontal else float(coordinate)
		var coordinateOffset: int = int(_offset if hasOffset else 0) if (coordinate == 0 || coordinate == pointNumber) else 0
		var offsetFactor: int = 1 if coordinate == 0 else -1

		points.append(Vector2(
			x * cellSize + (1 if isHorizontal else coordinateOffset * offsetFactor),
			y * cellSize + (coordinateOffset * offsetFactor if isHorizontal else 1),
		))
	line.points = points

	return line
