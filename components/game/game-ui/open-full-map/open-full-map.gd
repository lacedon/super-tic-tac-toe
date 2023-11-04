extends Button
class_name TTT_UI_Open_Full_Map

@export var state: TTT_State

func _ready():
	text = "Zoom out"
	pressed.connect(_button_pressed)

func _button_pressed():
	var cameraBlock = TTT_State_Selectors.getCameraBlock(state)
	if cameraBlock == TTT_State.cameraDisabledIndex:
		state.updateCameraBlock(TTT_State.mainFieldIndex)
		text = "Zoom in"
	else:
		state.updateCameraBlock(TTT_State.cameraDisabledIndex)
		text = "Zoom out"
