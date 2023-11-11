const ControllerFinishGame = preload("./finish-game.gd")
const ControllerUpdatePlayer = preload("./update-player.gd")
const ControllerUpdateOpenBlock = preload("./update-open-block.gd")

const lines = [
	{ start = 0, stepSize = 1 },
	{ start = 0, stepSize = 3 },
	{ start = 0, stepSize = 4 },
	{ start = 1, stepSize = 3 },
	{ start = 2, stepSize = 2 },
	{ start = 2, stepSize = 3 },
	{ start = 3, stepSize = 1 },
	{ start = 6, stepSize = 1 },
]

static func updateField(state: TTT_State, index: int, parentIndex: int):
	var logId: String = "> updateField[" + str(index) + "," + str(parentIndex) + "]"
	prints(logId, "start")

	var parent = state.fields[parentIndex]
	if parent.type != TTT_Cell_Resource.FieldType.field || !parent.inner[index]:
		assert("Cannot find field [" + str(parentIndex) + "][" + str(index) + "]. It\"s not field cell.")

	var value = TTT_Cell_Resource.FieldType.x if state.currentPlayer == TTT_State.PlayerSign.x else TTT_Cell_Resource.FieldType.o
	_updateCellType(state, index, parentIndex, value)
	prints("\t", logId, "value", value)

	var finishedLine =_getFinishedLine(state.fields if parentIndex == TTT_State.mainFieldIndex else parent.inner)
	prints("\t", logId, "finishedLine", finishedLine)
	if finishedLine:
		_updateCellType(state, parentIndex, TTT_State.mainFieldIndex, finishedLine)

		var finishedField = _getFinishedLine(state.fields)
		if finishedField:
			var winner = TTT_State.PlayerSign.x if finishedField == TTT_Cell_Resource.FieldType.x else TTT_State.PlayerSign.o
			ControllerFinishGame.finishGame(state, winner)
			prints("\t", logId, "finish game", winner)
		elif !_hasAvailableFields(state.fields):
			ControllerFinishGame.finishGame(state, state.currentPlayer, true)
			prints("\t", logId, "finish game", 'It\'s draw')
		else:
			ControllerUpdateOpenBlock.updateOpenBlock(state, TTT_State.mainFieldIndex)
			prints("\t", logId, "update openBlock", TTT_State.mainFieldIndex)
	elif parentIndex == TTT_State.mainFieldIndex && !_hasAvailableFields(state.fields):
		ControllerFinishGame.finishGame(state, state.currentPlayer, true)
		prints("\t", logId, "finish game", 'It\'s draw')
	elif (state.fields[index].type == TTT_Cell_Resource.FieldType.field):
		ControllerUpdateOpenBlock.updateOpenBlock(state, index)
		prints("\t", logId, "update openBlock", index)
	else:
		ControllerUpdateOpenBlock.updateOpenBlock(state, TTT_State.mainFieldIndex)
		prints("\t", logId, "update openBlock", TTT_State.mainFieldIndex)

	ControllerUpdatePlayer.togglePlayer(state, true)
	prints("\t", logId, "togglePlayer")
	prints(logId, "end", index, parentIndex)

static func _updateCellType(state: TTT_State, index: int, parentIndex: int, value: TTT_Cell_Resource.FieldType):
	if (parentIndex == TTT_State.mainFieldIndex):
		state.fields[index].type = value
	else:
		state.fields[parentIndex].inner[index].type = value

	state.emit_signal("cellTypeChanged", parentIndex, index, value)

static func _getFinishedLine(fieldList: Array[TTT_Cell_Resource]):
	for line in lines:
		var fieldType: TTT_Cell_Resource.FieldType = fieldList[line.start].type
		if (
			fieldType != TTT_Cell_Resource.FieldType.x &&
			fieldType != TTT_Cell_Resource.FieldType.o
		):
			continue

		var lineSteps: int = 0
		for stepInLine in range(gameSettings.cellNumber):
			if fieldList[line.start + stepInLine * line.stepSize].type == fieldType:
				lineSteps += 1
			else:
				break

		if lineSteps == gameSettings.cellNumberForLine: return fieldType

	return null

static func _hasAvailableFields(fieldList: Array[TTT_Cell_Resource]) -> bool:
	for field in fieldList:
		if field.type == TTT_Cell_Resource.FieldType.none || field.type == TTT_Cell_Resource.FieldType.field: return true
	return false
