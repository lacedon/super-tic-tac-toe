const changeGameStatusController = preload('./change-game-status.gd')

static func changePlayerSign(state: TTT_State, player: TTT_State.PlayerSign):
	state.activePlayers = [player]
	var ai = state.find_child('AI', true, false)
	if ai:
		ai.player = TTT_State_Helpers.getOppositePlayer(player)

	changeGameStatusController.changeGameStatus(state, TTT_State.GameStatus.running)
