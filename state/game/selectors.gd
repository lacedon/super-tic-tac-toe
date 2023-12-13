class_name TTT_State_Selectors


static func getFieldType(
	state: TTT_State, index: int, parentIndex: int = TTT_State.mainFieldIndex
) -> TTT_Cell_Resource.FieldType:
	if parentIndex == TTT_State.mainFieldIndex:
		return state.fields[index].type

	if state.fields[parentIndex].type == TTT_Cell_Resource.FieldType.field:
		return state.fields[parentIndex].inner[index].type

	assert("Cannot find field [" + str(parentIndex) + "][" + str(index) + ']. It"s not field cell.')
	return TTT_Cell_Resource.FieldType.none


static func getFieldList(state: TTT_State, parentIndex: int) -> Array[TTT_Cell_Resource]:
	return (
		state.fields if parentIndex == TTT_State.mainFieldIndex else state.fields[parentIndex].inner
	)


static func getIsFieldAvailable(fieldList: Array[TTT_Cell_Resource]) -> bool:
	for field in fieldList:
		if field.type == TTT_Cell_Resource.FieldType.none:
			return true
		if field.type == TTT_Cell_Resource.FieldType.field && getIsFieldAvailable(field.inner):
			return true
	return false


static func getIsFieldEmpty(fieldList: Array[TTT_Cell_Resource]) -> bool:
	for cell in fieldList:
		if cell.type != TTT_Cell_Resource.FieldType.none:
			return false
	return true


static func getOpenBlock(state: TTT_State) -> int:
	return state.openBlock


static func getPrevOpenBlock(state: TTT_State) -> int:
	return state.prevOpenBlock


static func getCurrentPlayer(state: TTT_State) -> TTT_State.PlayerSign:
	return state.currentPlayer


static func getIsCurrentPlayerActive(state: TTT_State) -> bool:
	return state.activePlayers.has(state.currentPlayer)


static func getIsGameOver(state: TTT_State) -> bool:
	return state.isGameOver


static func getShouldShowZoom(state: TTT_State) -> bool:
	return state.nestingLevel != TTT_State.NestingLevel.one


static func getNestingLevel(state: TTT_State) -> TTT_State.NestingLevel:
	return state.nestingLevel


static func getGameStatus(state: TTT_State) -> TTT_State.GameStatus:
	return state.status


static func getIsGameRunning(state: TTT_State) -> bool:
	return state.status == TTT_State.GameStatus.running
