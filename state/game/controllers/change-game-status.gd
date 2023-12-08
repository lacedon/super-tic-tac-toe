static func changeGameStatus(state: TTT_State, value: TTT_State.GameStatus):
	state.status = value
	state.emit_signal(state.statusChanged.get_name(), value)
