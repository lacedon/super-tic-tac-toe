extends Control

var button: Control

@export var state: TTT_State
@export var cellSize: int
@export var parentIndex: int
@export var handleButtonPressed: Callable

func _init(
	initState: TTT_State,
	initCellSize: int,
	initParentIndex: int,
	initHandleButtonPressed: Callable,
):
	state = initState
	cellSize = initCellSize
	parentIndex = initParentIndex
	handleButtonPressed = initHandleButtonPressed

func toggle(stateOpenBlock: int, childType: TTT_State.FieldType):
	if _shouldDrawButton(stateOpenBlock, childType):
		if !button:
			button = _createButton()
			add_child(button)
	elif button:
		remove_child(button)
		button = null

func _shouldDrawButton(
	stateOpenBlock: int,
	childType: TTT_State.FieldType
) -> bool:
	if !TTT_State_Selectors.getIsCurrentPlayerActive(state): return false

	# If the current cell is already finished
	if childType == TTT_State.FieldType.x || childType == TTT_State.FieldType.o: return false

	# If the current cell is the top cell and top field is open
	if parentIndex == TTT_State.mainFieldIndex && stateOpenBlock == TTT_State.mainFieldIndex: return true

	# If the current cell is the inner cell and the parent cell is open
	if parentIndex != TTT_State.mainFieldIndex && stateOpenBlock == parentIndex: return true

	return false

func _createButton():
	var halfCellSize: int = roundi(float(cellSize) / 2)
	var newButton = Button.new()
	newButton.size.x = cellSize
	newButton.size.y = cellSize
	newButton.position.x = -halfCellSize
	newButton.position.y = -halfCellSize
	newButton.pressed.connect(handleButtonPressed)
	return newButton
