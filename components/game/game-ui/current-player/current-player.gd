extends Control
class_name TTT_UI_Current_Player

@export var state: TTT_State
@export var playerX: Control
@export var playerY: Control

func _ready():
	_updatePlayerSign(TTT_State_Selectors.getCurrentPlayer(state))

func _enter_tree():
	state.connect("currentPlayerChanged", _updatePlayerSign)

func _exit_tree():
	state.disconnect("currentPlayerChanged", _updatePlayerSign)

func _updatePlayerSign(currentPlayer: TTT_State.PlayerSign):
	if currentPlayer == TTT_State.PlayerSign.x:
		playerX.modulate = Color(1.0, 1.0, 1.0, 1.0)
		playerY.modulate = Color(1.0, 1.0, 1.0, 0.25)
	else:
		playerX.modulate = Color(1.0, 1.0, 1.0, 0.25)
		playerY.modulate = Color(1.0, 1.0, 1.0, 1.0)
