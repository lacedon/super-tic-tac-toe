extends Button

signal restartGame()
signal toggleInGameMenu()

func _enter_tree():
	eventEmitter.addEmitter("restartGame", self)
	eventEmitter.addEmitter("toggleInGameMenu", self)
	connect("pressed", emitRestartGame)

func _exit_tree():
	eventEmitter.removeEmitter("restartGame", self)
	eventEmitter.removeEmitter("toggleInGameMenu", self)
	disconnect("pressed", emitRestartGame)

func emitRestartGame():
	emit_signal('restartGame')
	emit_signal('toggleInGameMenu')

