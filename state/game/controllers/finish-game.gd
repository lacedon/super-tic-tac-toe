static func finishGame(state: TTT_State, winner: TTT_State.PlayerSign, isDraw: bool = false):
	state.isGameOver = true
	state.emit_signal("gameOver", winner, isDraw)
	prints(winner, "WINER! WINER! CHIKEN DINNER!")
