extends Control

const ChildHelper = preload('./child.gd')
const ButtonHelper = preload('./button.gd')

@export var parentIndex: int = TTT_State.mainFieldIndex
@export var index: int
@export var state: TTT_State
@export var cellSize: int = uiSettings.cellSize
var button: ButtonHelper
var child: ChildHelper

func _ready():
	var stateChildType = TTT_State_Selectors.getFieldType(state, index, parentIndex)
	var stateOpenBlock = TTT_State_Selectors.getOpenBlock(state)

	child = ChildHelper.new(state, cellSize, index)
	child.toggle(stateChildType)
	add_child(child)

	button = ButtonHelper.new(state, cellSize, parentIndex, _handleButtonPressed)
	button.toggle(stateOpenBlock, stateChildType)
	add_child(button)

func _enter_tree():
	state.connect("openBlockChanged", _updateOpenBlock)
	state.connect("cellTypeChanged", _updateCellType)
	state.connect("currentPlayerChanged", _handleNewPlayer)

func _exit_tree():
	state.disconnect("openBlockChanged", _updateOpenBlock)
	state.disconnect("cellTypeChanged", _updateCellType)
	state.disconnect("currentPlayerChanged", _handleNewPlayer)

func _handleNewPlayer(_player: int):
	button.toggle(
		TTT_State_Selectors.getOpenBlock(state),
		TTT_State_Selectors.getFieldType(state, index, parentIndex),
	)

func _updateOpenBlock(openBlock: int):
	button.toggle(openBlock, TTT_State_Selectors.getFieldType(state, index, parentIndex))

func _updateCellType(updatedCellParentIndex: int, updatedCellIndex: int, newType: TTT_Cell_Resource.FieldType):
	if parentIndex != updatedCellParentIndex || index != updatedCellIndex: return
	child.toggle(newType)
	button.toggle(TTT_State_Selectors.getOpenBlock(state), newType)

func _handleButtonPressed():
	var cellType = TTT_State_Selectors.getFieldType(state, index)

	if cellType == TTT_Cell_Resource.FieldType.field:
		state.updateOpenBlock(index)
	else:
		state.updateField(index, parentIndex)
