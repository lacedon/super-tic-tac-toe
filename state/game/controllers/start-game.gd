const scriptAI = preload("res://components/game/ai/ai.gd")
const changeGameStatusController = preload('./change-game-status.gd')

static func startGame(state: TTT_State):
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
			state.status = TTT_State.GameStatus.choosePlayer
			state.activePlayers = [TTT_State.PlayerSign.x]

			var ai: TTT_AI = scriptAI.new()
			ai.state = state
			ai.player = TTT_State.PlayerSign.o
			ai.name = 'AI'
			state.add_child(ai)

			changeGameStatusController.changeGameStatus(state, TTT_State.GameStatus.choosePlayer)
		GameSettings.GameMode.hotSeat:
			state.activePlayers = [TTT_State.PlayerSign.x, TTT_State.PlayerSign.o]

	state.emit_signal(state.restart.get_name())
