static func togglePlayer(state: TTT_State, toggle: bool, value: TTT_State.PlayerSign = TTT_State.PlayerSign.x):
	var newValue = value
	if toggle:
		newValue = TTT_State_Helpers.getOppositePlayer(state.currentPlayer)

	state.currentPlayer = newValue

	state.emit_signal(state.currentPlayerChanged.get_name(), newValue)
