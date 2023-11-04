static func updateOpenBlock(state: TTT_State, value: int):
	print('> updateOpenBlock[', value, ']')
	if TTT_State_Selectors.getIsFieldFull(state.fields[value].inner):
		value = TTT_State.mainFieldIndex

	state.prevOpenBlock = state.openBlock
	state.openBlock = value
	state.emit_signal("openBlockChanged", value)

	if state.cameraBlock == TTT_State.cameraDisabledIndex:
		state.emit_signal("cameraBlockChanged", value)
