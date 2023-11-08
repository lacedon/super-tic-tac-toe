extends Button
class_name TTT_UI_Open_Full_Map

signal toggleCamera()

func _enter_tree():
	text = "Zoom"
	eventEmitter.addEmitter('toggleCamera', self)
	pressed.connect(_button_pressed)

func _exit_tree():
	eventEmitter.removeEmitter('toggleCamera', self)

func _button_pressed():
	emit_signal('toggleCamera')
