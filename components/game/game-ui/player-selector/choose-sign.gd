extends Button

signal choosePlayerSign(playerSign: TTT_State.PlayerSign)

@export var playerSign: TTT_State.PlayerSign

func _enter_tree():
	eventEmitter.addEmitter(choosePlayerSign.get_name(), self)
	connect(pressed.get_name(), startGame)

func _exit_tree():
	eventEmitter.removeEmitter(choosePlayerSign.get_name(), self)
	disconnect(pressed.get_name(), startGame)

func startGame():
	emit_signal(choosePlayerSign.get_name(), playerSign)
