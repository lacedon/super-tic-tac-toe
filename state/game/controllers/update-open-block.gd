static func updateOpenBlock(state: TTT_State, value: int):
	if !TTT_State_Selectors.getIsFieldAvailable(state.fields[value].inner):
		value = TTT_State.mainFieldIndex

	state.prevOpenBlock = state.openBlock
	state.openBlock = value
	state.emit_signal(state.openBlockChanged.get_name(), value)
