extends Button
class_name TTT_UI_Open_Full_Map

@export var state: TTT_State

signal toggleCamera()

func _enter_tree():
	if !TTT_State_Selectors.getShouldShowZoom(state):
		hide()
		return

	text = "Zoom"
	eventEmitter.addEmitter('toggleCamera', self)
	pressed.connect(_button_pressed)

func _exit_tree():
	eventEmitter.removeEmitter('toggleCamera', self)

func _button_pressed():
	emit_signal('toggleCamera')
