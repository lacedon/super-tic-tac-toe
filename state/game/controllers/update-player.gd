static func togglePlayer(state: TTT_State, toggle: bool, value: TTT_State.PlayerSign = TTT_State.PlayerSign.x):
	# var logId: String = "> togglePlayer[" + str(toggle) + "," + str(value) + "]"
	# prints(logId, "start")

	var newValue = value
	if toggle:
		newValue = TTT_State.PlayerSign.o if state.currentPlayer == TTT_State.PlayerSign.x else TTT_State.PlayerSign.x
		# prints("\t", logId, "newValue updated", newValue)

	state.currentPlayer = newValue
	# prints("\t", logId, "updateValue")

	state.emit_signal("currentPlayerChanged", newValue)
	# prints("\t", logId, "emit_signal")

	# prints(logId, "end")
