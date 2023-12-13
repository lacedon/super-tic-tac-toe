extends Button

const fieldNoice = preload("res://assets/field-noise.mp3")
const ButtonSound = preload('res://components/common/button-sound.gd')

@export var state: TTT_State
@export var cellSize: int
@export var index: int
@export var parentIndex: int
@export var handleButtonPressed: Callable

func _init(
	initState: TTT_State,
	initCellSize: int,
	initIndex: int,
	initParentIndex: int,
	initHandleButtonPressed: Callable,
):
	name = 'CellButton'
	state = initState
	cellSize = initCellSize
	index = initIndex
	parentIndex = initParentIndex
	handleButtonPressed = initHandleButtonPressed

	_setDefaultStyles()

func toggle(stateOpenBlock: int, childType: TTT_Cell_Resource.FieldType):
	if _shouldDrawButton(stateOpenBlock, childType):
		show()
	else:
		hide()

func _shouldDrawButton(
	stateOpenBlock: int,
	childType: TTT_Cell_Resource.FieldType
) -> bool:
	if !TTT_State_Selectors.getIsCurrentPlayerActive(state): return false
	if !TTT_State_Selectors.getIsGameRunning(state): return false

	# Cell with choosing field and it's available
	if (
		TTT_State_Selectors.getFieldType(state, index, parentIndex) == TTT_Cell_Resource.FieldType.field &&
		!TTT_State_Selectors.getIsFieldAvailable(TTT_State_Selectors.getFieldList(state, index))
	):
		return false

	# If the current cell is already finished
	if childType == TTT_Cell_Resource.FieldType.x || childType == TTT_Cell_Resource.FieldType.o:
		return false

	# If the field of the current cell is open
	if parentIndex == stateOpenBlock: return true

	return false

func _setDefaultStyles():
	var halfCellSize: int = roundi(float(cellSize) / 2)
	size.x = cellSize
	size.y = cellSize
	position.x = -halfCellSize
	position.y = -halfCellSize
	pressed.connect(handleButtonPressed)

	var buttonStyler = ButtonStyler.new()
	buttonStyler.name = 'Cell-Button-Styler'
	buttonStyler.style = 'field-button'
	add_child(buttonStyler)

	var buttonSound = ButtonSound.new()
	buttonSound.name = 'Cell-Button-Sound'
	buttonSound.pressSound = fieldNoice
	add_child(buttonSound)
