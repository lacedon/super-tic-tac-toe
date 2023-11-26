static func togglePlayer(state: TTT_State, toggle: bool, value: TTT_State.PlayerSign = TTT_State.PlayerSign.x):
	var newValue = value
	if toggle:
		newValue = TTT_State.PlayerSign.o if state.currentPlayer == TTT_State.PlayerSign.x else TTT_State.PlayerSign.x

	state.currentPlayer = newValue

	state.emit_signal(state.currentPlayerChanged.get_name(), newValue)
