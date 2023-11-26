const randoDifficulty = preload('./rando.gd')

static func getCellsToChoose(state: TTT_State, openBlock: int, playerSign: TTT_State.PlayerSign) -> Array[int]:
	var prevOpenBlock = TTT_State_Selectors.getPrevOpenBlock(state)
	if prevOpenBlock == TTT_State.mainFieldIndex:
		return randoDifficulty.getCellsToChoose(state, openBlock, playerSign)

	var allFields = TTT_State_Selectors.getFieldList(state, openBlock)
	var field = allFields[prevOpenBlock]
	if field.type == TTT_Cell_Resource.FieldType.none:
		return [prevOpenBlock]

	return randoDifficulty.getCellsToChoose(state, openBlock, playerSign)
