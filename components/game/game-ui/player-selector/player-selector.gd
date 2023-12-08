extends Control

@export var state: TTT_State

func _ready():
	toggleView(TTT_State_Selectors.getGameStatus(state))

func _enter_tree():
	state.connect(state.statusChanged.get_name(), toggleView)

func _exit_tree():
	state.disconnect(state.statusChanged.get_name(), toggleView)

func toggleView(gameStatus: TTT_State.GameStatus):
	if gameStatus == TTT_State.GameStatus.choosePlayer:
		show()
	else:
		hide()
