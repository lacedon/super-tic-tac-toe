extends Control

const winnerSound: AudioStreamMP3 = preload('res://assets/game-over-win.mp3')
const homeScene: String = 'res://scenes/menu/menu.tscn'

@export var state: TTT_State
@export var titleNode: Label
@export var playerNameNode: Control

func _enter_tree():
	hide()
	if state:
		state.connect(state.gameOver.get_name(), showWinner)
		state.connect(state.restart.get_name(), _handleRestart)
	else:
		prints('WARN:', 'State is not provided', self)

func _exit_tree():
	if state:
		state.disconnect(state.gameOver.get_name(), showWinner)
		state.disconnect(state.restart.get_name(), _handleRestart)

func _notification(what: int):
	if !visible: return
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		sceneChanger.changeScene(homeScene)

func _handleRestart():
	hide()

func showWinner(winner: TTT_State.PlayerSign, isDraw: bool):
	SoundManager.play_ui_sound(winnerSound)

	if isDraw:
		titleNode.text = 'It\'s a Draw!'

		var xSign = TTT_Sign.new()
		xSign.centererByX = true
		xSign.value = TTT_Cell_Resource.FieldType.x
		xSign.cellSize = gameSettings.cellSize
		xSign.layout_mode = 1
		xSign.anchors_preset = PRESET_CENTER

		var oSign = TTT_Sign.new()
		oSign.centererByX = true
		oSign.value = TTT_Cell_Resource.FieldType.o
		oSign.cellSize = gameSettings.cellSize
		oSign.layout_mode = 1
		oSign.anchors_preset = PRESET_CENTER

		var container = HBoxContainer.new()

		container.layout_mode = 1
		container.anchors_preset = PRESET_CENTER
		container.add_child(xSign)
		container.add_child(oSign)

		playerNameNode.add_child(container)
		playerNameNode.custom_minimum_size = Vector2(
			playerNameNode.custom_minimum_size.x * 2,
			playerNameNode.custom_minimum_size.y
		)
	else:
		titleNode.text = 'Winner is'

		var winnerSign = TTT_Sign.new()
		winnerSign.centererByX = true
		winnerSign.value = TTT_State_Helpers.getPlayerFieldType(winner)
		winnerSign.cellSize = gameSettings.cellSize
		winnerSign.layout_mode = 1
		winnerSign.anchors_preset = PRESET_CENTER
		playerNameNode.add_child(winnerSign)

	show()
