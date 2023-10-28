class_name TTT_State_Selectors

static func getFieldType(state: TTT_State, index: int, parentIndex: int = TTT_State.mainFieldIndex) -> TTT_Cell_Resource.FieldType:
	if parentIndex == TTT_State.mainFieldIndex: return state.fields[index].type

	if state.fields[parentIndex].type == TTT_Cell_Resource.FieldType.field:
		return state.fields[parentIndex].inner[index].type

	assert("Cannot find field [" + str(parentIndex) + "][" + str(index) + "]. It\"s not field cell.")
	return TTT_Cell_Resource.FieldType.none

static func getFieldList(state: TTT_State, parentIndex: int) -> Array[TTT_Cell_Resource]:
	return state.fields if parentIndex == TTT_State.mainFieldIndex else state.fields[parentIndex].inner

static func getIsFieldFull(fieldList: Array[TTT_Cell_Resource]) -> bool:
	for cell in fieldList:
		if cell.type == TTT_Cell_Resource.FieldType.none:
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
