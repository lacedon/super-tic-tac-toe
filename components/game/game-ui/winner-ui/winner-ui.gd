extends Control

const TTTSign = preload("res://components/game/sign/sign.gd")
const winnerSound = preload('res://assets/game-over-win.mp3')

@export var state: TTT_State
@export var titleNode: Label
@export var playerNameNode: Control

func _enter_tree():
	hide()
	if state:
		state.connect("gameOver", showWinner)
		state.connect("restart", _handleRestart)
	else:
		prints('WARN:', 'State is not provided', self)
		showWinner(TTT_State.PlayerSign.o, true)

func _exit_tree():
	if state:
		state.disconnect("gameOver", showWinner)
		state.disconnect("restart", _handleRestart)

func _handleRestart():
	hide()

func showWinner(winner: TTT_State.PlayerSign, isDraw: bool):
	SoundManager.play_ui_sound(winnerSound)

	if isDraw:
		titleNode.text = 'It\'s a Draw!'

		var xSign = TTTSign.new()
		xSign.centererByX = true
		xSign.value = TTT_Cell_Resource.FieldType.x
		xSign.cellSize = gameSettings.cellSize
		xSign.layout_mode = 1
		xSign.anchors_preset = PRESET_CENTER

		var oSign = TTTSign.new()
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

		var winnerSign = TTTSign.new()
		winnerSign.centererByX = true
		winnerSign.value = TTT_Cell_Resource.FieldType.x if winner == TTT_State.PlayerSign.x else TTT_Cell_Resource.FieldType.o 
		winnerSign.cellSize = gameSettings.cellSize
		winnerSign.layout_mode = 1
		winnerSign.anchors_preset = PRESET_CENTER
		playerNameNode.add_child(winnerSign)

	show()
