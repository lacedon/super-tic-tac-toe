extends Control

const TTT_Game_Field: Resource = preload("res://components/game/game-field/game-field.gd")
const TTT_Sign: Resource = preload("res://components/game/sign/sign.gd")

var child: Control
var state: TTT_State
var cellSize: int
var index: int

func _init(
	initState: TTT_State,
	initCellSize: int,
	initIndex: int,
):
	state = initState
	cellSize = initCellSize
	index = initIndex

func toggle(childType: TTT_Cell_Resource.FieldType):
	if child: remove_child(child)
	child = _createChild(childType)
	if child: add_child(child)

func _createChild(childType: TTT_Cell_Resource.FieldType,):
	var halfCellSize: int = roundi(float(cellSize) / 2)
	var newChild = _createBaseChild(childType)
	if (newChild):
		newChild.position.x = -halfCellSize
		newChild.position.y = -halfCellSize
	return newChild

func _createBaseChild(childType: TTT_Cell_Resource.FieldType):
	match childType:
		TTT_Cell_Resource.FieldType.x: return _createSign(TTT_Cell_Resource.FieldType.x)
		TTT_Cell_Resource.FieldType.o: return _createSign(TTT_Cell_Resource.FieldType.o)
		TTT_Cell_Resource.FieldType.field: return _createGameField()
	return

func _createSign(value: TTT_Cell_Resource.FieldType) -> TTT_Sign:
	var instance: TTT_Sign = TTT_Sign.new()
	instance.name = "Sign"
	instance.cellSize = cellSize
	instance.value = value
	return instance

func _createGameField() -> TTT_Game_Field:
	var instance: TTT_Game_Field = TTT_Game_Field.new()
	instance.state = state
	instance.name = "GameField"
	instance.parentIndex = index
	instance.cellSize = roundi(float(cellSize) / gameSettings.cellNumber)

	return instance
