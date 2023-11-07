extends Control
class_name TTT_UI_Current_Player

const activePlayerStylebox = preload('res://themes/panel-styles/player-block-active.tres');
const unactivePlayerStylebox = preload('res://themes/panel-styles/player-block-unactive.tres');

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
		_highlightSign(playerX)
		_hideSign(playerY)
	else:
		_hideSign(playerX)
		_highlightSign(playerY)

func _hideSign(control: Control):
	control.modulate = Color(1.0, 1.0, 1.0, 0.25)
	control.add_theme_stylebox_override('panel', unactivePlayerStylebox)

func _highlightSign(control: Control):
	control.modulate = Color(1.0, 1.0, 1.0, 1.0)
	control.add_theme_stylebox_override('panel', activePlayerStylebox)
