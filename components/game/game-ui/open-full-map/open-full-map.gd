extends Button
class_name TTT_UI_Open_Full_Map

const fieldNoice = preload("res://assets/button-noise.mp3")
const ButtonSound = preload('res://components/common/button-sound.gd')

@export var state: TTT_State

signal toggleCamera()

func _enter_tree():
	if !TTT_State_Selectors.getShouldShowZoom(state) || gameSettings.disableZoom:
		hide()
		return

	text = "Zoom"
	eventEmitter.addEmitter(toggleCamera.get_name(), self)
	connect(pressed.get_name(), _button_pressed)

	var buttonSound = ButtonSound.new()
	buttonSound.name = 'ButtonSound'
	buttonSound.downSound = fieldNoice
	add_child(buttonSound)

func _exit_tree():
	eventEmitter.removeEmitter(toggleCamera.get_name(), self)
	disconnect(pressed.get_name(), _button_pressed)

func _button_pressed():
	emit_signal(toggleCamera.get_name())
