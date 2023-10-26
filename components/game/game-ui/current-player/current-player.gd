extends Label
class_name TTT_UI_Current_Player

@export var state: TTT_State

func _ready():
	_updatePlayerSign(TTT_State_Selectors.getCurrentPlayer(state))

func _enter_tree():
	state.connect("currentPlayerChanged", _updatePlayerSign)

func _exit_tree():
	state.disconnect("currentPlayerChanged", _updatePlayerSign)

func _updatePlayerSign(currentPlayer: TTT_State.PlayerSign):
	self.text = "Current player: " + _getPlayerSign(currentPlayer)
	self.add_theme_color_override("font_color", uiSettings.playerXColor if TTT_State_Selectors.getCurrentPlayer(state) == TTT_State.PlayerSign.x else uiSettings.playerOColor)

func _getPlayerSign(currentPlayer: TTT_State.PlayerSign) -> String:
	if currentPlayer == TTT_State.PlayerSign.x:
		return "X"
	else:
		return "O"
