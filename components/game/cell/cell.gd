extends Control

const ChildHelper = preload('./helper-child.gd')
const ButtonHelper = preload('./helper-button.gd')

@export var parentIndex: int = TTT_State.mainFieldIndex
@export var index: int
@export var state: TTT_State
@export var cellSize: int = gameSettings.cellSize
var buttonHelper: ButtonHelper
var childHelper: ChildHelper

func _init(
	initState: TTT_State = state,
	initCellSize: int = cellSize,
	initIndex: int = index,
	initParentIndex: int = parentIndex,
):
	parentIndex = initParentIndex
	index = initIndex
	state = initState
	cellSize = initCellSize

	childHelper = ChildHelper.new(state, cellSize, index)
	buttonHelper = ButtonHelper.new(state, cellSize, parentIndex, _handleButtonPressed)

func _ready():
	var stateChildType = TTT_State_Selectors.getFieldType(state, index, parentIndex)
	var stateOpenBlock = TTT_State_Selectors.getOpenBlock(state)

	childHelper.toggle(stateChildType)
	add_child(childHelper)

	buttonHelper.toggle(stateOpenBlock, stateChildType)
	add_child(buttonHelper)

func _enter_tree():
	state.connect(state.openBlockChanged.get_name(), _updateOpenBlock)
	state.connect(state.cellTypeChanged.get_name(), _updateCellType)
	state.connect(state.currentPlayerChanged.get_name(), _handleNewPlayer)
	state.connect(state.restart.get_name(), _handleRestart)
	state.connect(state.fieldChanged.get_name(), _handleFieldChanged)
	state.connect(state.turnMade.get_name(), buttonHelper.hide)

func _exit_tree():
	state.disconnect(state.openBlockChanged.get_name(), _updateOpenBlock)
	state.disconnect(state.cellTypeChanged.get_name(), _updateCellType)
	state.disconnect(state.currentPlayerChanged.get_name(), _handleNewPlayer)
	state.disconnect(state.restart.get_name(), _handleRestart)
	state.disconnect(state.fieldChanged.get_name(), _handleFieldChanged)
	state.disconnect(state.turnMade.get_name(), buttonHelper.hide)

func _handleRestart():
	var openBlock: = TTT_State_Selectors.getOpenBlock(state)
	var type: = TTT_State_Selectors.getFieldType(state, index, parentIndex)
	childHelper.toggle(type)
	buttonHelper.toggle(openBlock, type)

func _handleNewPlayer(_player: int):
	buttonHelper.toggle(
		TTT_State_Selectors.getOpenBlock(state),
		TTT_State_Selectors.getFieldType(state, index, parentIndex),
	)

func _updateOpenBlock(openBlock: int):
	buttonHelper.toggle(openBlock, TTT_State_Selectors.getFieldType(state, index, parentIndex))

func _updateCellType(updatedCellParentIndex: int, updatedCellIndex: int, newType: TTT_Cell_Resource.FieldType):
	if parentIndex != updatedCellParentIndex || index != updatedCellIndex: return
	buttonHelper.toggle(TTT_State_Selectors.getOpenBlock(state), newType)
	await childHelper.toggle(newType)

func _handleButtonPressed():
	state.makeTurn()
	var cellType = TTT_State_Selectors.getFieldType(state, index, parentIndex)

	if cellType == TTT_Cell_Resource.FieldType.field:
		state.updateOpenBlock(index)
	else:
		await _updateCellType(
			parentIndex,
			index,
			TTT_Cell_Resource.FieldType.x if TTT_State_Selectors.getCurrentPlayer(state) == TTT_State.PlayerSign.x else TTT_Cell_Resource.FieldType.o
		)

		state.updateField(index, parentIndex)

func _handleFieldChanged():
	var newType: = TTT_State_Selectors.getFieldType(state, index, parentIndex)
	buttonHelper.toggle(TTT_State_Selectors.getOpenBlock(state), newType)
	await childHelper.toggle(newType)
