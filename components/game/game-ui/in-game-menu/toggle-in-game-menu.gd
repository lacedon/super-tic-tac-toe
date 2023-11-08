extends Button

signal toggleInGameMenu()

func _enter_tree():
	eventEmitter.addEmitter("toggleInGameMenu", self)
	connect("pressed", emitToggleInGameMenu)

func _exit_tree():
	eventEmitter.removeEmitter("toggleInGameMenu", self)
	disconnect("pressed", emitToggleInGameMenu)

func emitToggleInGameMenu():
	emit_signal('toggleInGameMenu')
