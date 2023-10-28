extends Control

const TTTSign = preload("res://components/game/sign/sign.gd")

@export var state: TTT_State
@export var titleNode: Label
@export var playerNameNode: Control

func _enter_tree():
	hide()
	if state:
		state.connect("gameOver", showWinner)
	else:
		prints('WARN:', 'State is not provided', self)
		showWinner(TTT_State.PlayerSign.o, false)

func _exit_tree():
	if state: state.disconnect("gameOver", showWinner)

func showWinner(winner: TTT_State.PlayerSign, isDraw: bool):
	if isDraw:
		titleNode.text = 'It\'s a Draw!'
		playerNameNode.text = ''
	else:
		titleNode.text = 'Winner is'

		var winnerSign = TTTSign.new()
		winnerSign.centererByX = true
		winnerSign.value = TTT_Cell_Resource.FieldType.x if winner == TTT_State.PlayerSign.x else TTT_Cell_Resource.FieldType.o 
		winnerSign.cellSize = winnerSign.cellSize / 2
		winnerSign.position.x = -winnerSign.cellSize / 2
		playerNameNode.add_child(winnerSign)

	show()
