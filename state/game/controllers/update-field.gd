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
	if parent.type != TTT_State.FieldType.field || !parent.inner[index]:
		assert("Cannot find field [" + str(parentIndex) + "][" + str(index) + "]. It\"s not field cell.")

	var value = TTT_State.FieldType.x if state.currentPlayer == TTT_State.PlayerSign.x else TTT_State.FieldType.o
	_updateCellType(state, index, parentIndex, value)
	prints("\t", logId, "value", value)

	var finishedLine = _getFinishedLine(parent.inner)
	prints("\t", logId, "finishedLine", finishedLine)
	if finishedLine:
		_updateCellType(state, parentIndex, TTT_State.mainFieldIndex, finishedLine)

		var finishedField = _getFinishedLine(state.fields)
		if finishedField:
			var winner = TTT_State.PlayerSign.x if finishedField == TTT_State.FieldType.x else TTT_State.PlayerSign.o
			ControllerFinishGame.finishGame(state, winner)
			prints("\t", logId, "finish game", winner)
		elif !_hasAvailableFields(state.fields):
			ControllerFinishGame.finishGame(state, state.currentPlayer, true)
			prints("\t", logId, "finish game", 'It\'s draw')
		else:
			ControllerUpdateOpenBlock.updateOpenBlock(state, TTT_State.mainFieldIndex)
			# ControllerUpdateOpenBlock.updateOpenBlock(state, index)
			prints("\t", logId, "update openBlock", TTT_State.mainFieldIndex)
	elif (state.fields[index].type == TTT_State.FieldType.field):
		ControllerUpdateOpenBlock.updateOpenBlock(state, index)
		prints("\t", logId, "update openBlock", index)
	else:
		prints("\t", logId, "keep openBlock")

	ControllerUpdatePlayer.togglePlayer(state, true)
	prints("\t", logId, "togglePlayer")
	prints(logId, "end", index, parentIndex)

static func _updateCellType(state: TTT_State, index: int, parentIndex: int, value: TTT_State.FieldType):
	if (parentIndex == TTT_State.mainFieldIndex):
		state.fields[index].type = value
	else:
		state.fields[parentIndex].inner[index].type = value

	state.emit_signal("cellTypeChanged", parentIndex, index, value)

static func _getFinishedLine(fieldList: Array):
	for line in lines:
		var fieldType: TTT_State.FieldType = fieldList[line.start].type
		if (
			fieldType != TTT_State.FieldType.x &&
			fieldType != TTT_State.FieldType.o
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

static func _hasAvailableFields(fieldList: Array) -> bool:
	for field in fieldList:
		if field.type == TTT_State.FieldType.none || field.type == TTT_State.FieldType.field: return true
	return false
