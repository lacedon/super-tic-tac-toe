const ControllerFinishGame = preload("./finish-game.gd")
const ControllerUpdatePlayer = preload("./update-player.gd")
const ControllerUpdateOpenBlock = preload("./update-open-block.gd")

const lines = [
	{start = 0, stepSize = 1},
	{start = 0, stepSize = 3},
	{start = 0, stepSize = 4},
	{start = 1, stepSize = 3},
	{start = 2, stepSize = 2},
	{start = 2, stepSize = 3},
	{start = 3, stepSize = 1},
	{start = 6, stepSize = 1},
]


static func updateField(state: TTT_State, index: int, parentIndex: int):
	var parent: TTT_Cell_Resource = state.fields[parentIndex]
	if parent.type != TTT_Cell_Resource.FieldType.field || !parent.inner[index]:
		assert(
			"Cannot find field [" + str(parentIndex) + "][" + str(index) + ']. It"s not field cell.'
		)

	var value: TTT_Cell_Resource.FieldType = TTT_State_Helpers.getPlayerFieldType(
		state.currentPlayer
	)
	_updateCellType(state, index, parentIndex, value)

	var finishedLine: TTT_Cell_Resource.FieldType = _getFinishedLine(
		state.fields if parentIndex == TTT_State.mainFieldIndex else parent.inner
	)
	if finishedLine != TTT_Cell_Resource.FieldType.none:
		_updateCellType(state, parentIndex, TTT_State.mainFieldIndex, finishedLine)

		var finishedField: TTT_Cell_Resource.FieldType = _getFinishedLine(state.fields)
		if finishedField != TTT_Cell_Resource.FieldType.none:
			var winner: TTT_State.PlayerSign = TTT_State_Helpers.getPlayerSignByFieldType(finishedField)
			ControllerFinishGame.finishGame(state, winner)
		elif !TTT_State_Selectors.getIsFieldAvailable(state.fields):
			ControllerFinishGame.finishGame(state, state.currentPlayer, true)
		else:
			ControllerUpdateOpenBlock.updateOpenBlock(state, TTT_State.mainFieldIndex)
	elif parentIndex == TTT_State.mainFieldIndex && !TTT_State_Selectors.getIsFieldAvailable(state.fields):
		ControllerFinishGame.finishGame(state, state.currentPlayer, true)
	elif state.fields[index].type == TTT_Cell_Resource.FieldType.field:
		ControllerUpdateOpenBlock.updateOpenBlock(state, index)
	else:
		ControllerUpdateOpenBlock.updateOpenBlock(state, TTT_State.mainFieldIndex)

	ControllerUpdatePlayer.togglePlayer(state, true)

static func _updateCellType(
	state: TTT_State, index: int, parentIndex: int, value: TTT_Cell_Resource.FieldType
):
	if parentIndex == TTT_State.mainFieldIndex:
		state.fields[index].type = value
	else:
		state.fields[parentIndex].inner[index].type = value

	state.emit_signal(state.cellTypeChanged.get_name(), parentIndex, index, value)

static func _getFinishedLine(fieldList: Array[TTT_Cell_Resource]) -> TTT_Cell_Resource.FieldType:
	for line in lines:
		var fieldType: TTT_Cell_Resource.FieldType = fieldList[line.start].type
		if fieldType != TTT_Cell_Resource.FieldType.x && fieldType != TTT_Cell_Resource.FieldType.o:
			continue

		var lineSteps: int = 0
		for stepInLine in range(gameSettings.cellNumber):
			if fieldList[line.start + stepInLine * line.stepSize].type == fieldType:
				lineSteps += 1
			else:
				break

		if lineSteps == gameSettings.cellNumberForLine:
			return fieldType

	return TTT_Cell_Resource.FieldType.none
