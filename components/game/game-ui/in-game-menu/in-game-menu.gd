extends Control

func _enter_tree():
	eventEmitter.addListener("toggleInGameMenu", toggleVisibility)

func _exit_tree():
	eventEmitter.removeListener("toggleInGameMenu", toggleVisibility)

func toggleVisibility():
	if self.visible:
		self.hide()
	else:
		self.show()
