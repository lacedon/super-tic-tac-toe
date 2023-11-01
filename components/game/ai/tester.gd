extends Node

@export var ai: TTT_AI
@export var state: TTT_State
@export var gameField: TTT_Game_Field

func _enter_tree():
	state.connect("cellTypeChanged", _updateCellType)

func _exit_tree():
	state.disconnect("cellTypeChanged", _updateCellType)

func _updateCellType(updatedCellParentIndex: int, updatedCellIndex: int, newType: TTT_Cell_Resource.FieldType):
	print('test')
	# child.toggle(newType)
	# button.toggle(TTT_State_Selectors.getOpenBlock(state), newType)
