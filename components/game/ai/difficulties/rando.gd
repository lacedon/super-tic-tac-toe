static func getCellsToChoose(state: TTT_State, openBlock: int, _playerSign: TTT_State.PlayerSign) -> Array[int]:
	var allFields = TTT_State_Selectors.getFieldList(state, openBlock)
	var options: Array[int] = []

	for fieldIndex in range(allFields.size()):
		var field = allFields[fieldIndex]
		if (
			field.type == TTT_Cell_Resource.FieldType.none ||
			field.type == TTT_Cell_Resource.FieldType.field
		):
			options.append(fieldIndex)

	return options
