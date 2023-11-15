const scriptAI = preload("res://components/game/ai/ai.gd")

static func startGame(state: TTT_State):
	prints('Restart game')

	state.openBlock = TTT_State.mainFieldIndex
	state.prevOpenBlock = TTT_State.mainFieldIndex
	state.currentPlayer = TTT_State.PlayerSign.x
	state.isGameOver = false
	for child in state.get_children():
		state.remove_child(child)

	state.fields = TTT_Cell_Resource.createEmptyFieldList(
		TTT_Cell_Resource.FieldType.none if state.nestingLevel == TTT_State.NestingLevel.one else TTT_Cell_Resource.FieldType.field
	)

	if !state.workWithGlobalSettings: return

	match gameSettings.mode:
		GameSettings.GameMode.vsAI:
			state.activePlayers = [TTT_State.PlayerSign.x]

			var ai: TTT_AI = scriptAI.new()
			ai.state = state
			ai.player = TTT_State.PlayerSign.o
			ai.name = 'AI-' + gameSettings.aiDificulty
			state.add_child(ai)
		GameSettings.GameMode.hotSeat:
			state.activePlayers = [TTT_State.PlayerSign.x, TTT_State.PlayerSign.o]

	state.emit_signal('restart')
