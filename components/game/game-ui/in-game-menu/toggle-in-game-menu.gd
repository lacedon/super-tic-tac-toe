extends Button

signal toggleInGameMenu()

const fieldNoice = preload("res://assets/button-noise.mp3")
const ButtonSound = preload('res://components/common/button-sound.gd')

func _enter_tree():
	eventEmitter.addEmitter("toggleInGameMenu", self)
	connect("pressed", emitToggleInGameMenu)

	var buttonSound = ButtonSound.new()
	buttonSound.name = 'ButtonSound'
	buttonSound.downSound = fieldNoice
	add_child(buttonSound)

func _exit_tree():
	eventEmitter.removeEmitter("toggleInGameMenu", self)
	disconnect("pressed", emitToggleInGameMenu)

func emitToggleInGameMenu():
	emit_signal('toggleInGameMenu')
