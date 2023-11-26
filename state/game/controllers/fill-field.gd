const ControllerFinishGame = preload("./finish-game.gd")
const ControllerUpdatePlayer = preload("./update-player.gd")
const ControllerUpdateOpenBlock = preload("./update-open-block.gd")

const lines = [
	{ start = 0, stepSize = 1 },
	{ start = 0, stepSize = 3 },
	{ start = 0, stepSize = 4 },
	{ start = 1, stepSize = 3 },
	{ start = 2, stepSize = 2 },
	{ start = 2, stepSize = 3 },
	{ start = 3, stepSize = 1 },
	{ start = 6, stepSize = 1 },
]

static func fillField(state: TTT_State, parentIndex: int, value: Array[TTT_Cell_Resource]):
	state.fields[parentIndex].inner = value
	state.emit_signal(state.fieldChanged.get_name())
