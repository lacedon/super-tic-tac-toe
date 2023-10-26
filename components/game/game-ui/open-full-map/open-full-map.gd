extends Button
class_name TTT_UI_Open_Full_Map

@export var state: TTT_State

func _ready():
	text = "Full View"
	pressed.connect(_button_pressed)

func _button_pressed():
	var openBlock = TTT_State_Selectors.getOpenBlock(state)
	state.updateOpenBlock(
		TTT_State_Selectors.getPrevOpenBlock(state) if openBlock == TTT_State.mainFieldIndex else TTT_State.mainFieldIndex
	)
