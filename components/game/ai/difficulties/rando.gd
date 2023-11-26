static func getCellsToChoose(state: TTT_State, openBlock: int, _playerSign: TTT_State.PlayerSign) -> Array[int]:
	var fieldList = TTT_State_Selectors.getFieldList(state, openBlock)
	var options: Array[int] = []

	for fieldIndex in range(fieldList.size()):
		var field = fieldList[fieldIndex]
		if field.type == TTT_Cell_Resource.FieldType.none:
			options.append(fieldIndex)

		if (
			field.type == TTT_Cell_Resource.FieldType.field &&
			TTT_State_Selectors.getIsFieldAvailable(fieldList[fieldIndex].inner)
		):
			options.append(fieldIndex)

	return options
