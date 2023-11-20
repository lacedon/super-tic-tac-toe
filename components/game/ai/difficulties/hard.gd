const easyAI = preload('./easy.gd')

static func getCellsToChoose(state: TTT_State, openBlock: int, playerSign: TTT_State.PlayerSign) -> Array[int]:
	return easyAI.getCellsToChoose(state, openBlock, playerSign)
