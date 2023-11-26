extends Button

signal toggleInGameMenu()

const fieldNoice = preload("res://assets/button-noise.mp3")
const ButtonSound = preload('res://components/common/button-sound.gd')

func _enter_tree():
	eventEmitter.addEmitter(toggleInGameMenu.get_name(), self)
	connect(pressed.get_name(), emitToggleInGameMenu)

	var buttonSound = ButtonSound.new()
	buttonSound.name = 'ButtonSound'
	buttonSound.downSound = fieldNoice
	add_child(buttonSound)

func _exit_tree():
	eventEmitter.removeEmitter(toggleInGameMenu.get_name(), self)
	disconnect(pressed.get_name(), emitToggleInGameMenu)

func emitToggleInGameMenu():
	emit_signal(toggleInGameMenu.get_name())
