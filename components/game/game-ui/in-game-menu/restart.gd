extends Button

signal restartGame()
signal toggleInGameMenu()

func _enter_tree():
	eventEmitter.addEmitter(restartGame.get_name(), self)
	eventEmitter.addEmitter(toggleInGameMenu.get_name(), self)
	connect(pressed.get_name(), emitRestartGame)

func _exit_tree():
	eventEmitter.removeEmitter(restartGame.get_name(), self)
	eventEmitter.removeEmitter(toggleInGameMenu.get_name(), self)
	disconnect(pressed.get_name(), emitRestartGame)

func emitRestartGame():
	emit_signal(restartGame.get_name())
	emit_signal(toggleInGameMenu.get_name())
