extends Node2D

const TTT_Game_Field: Resource = preload("res://components/game/game-field/game-field.gd")
const TTT_Sign: Resource = preload("res://components/game/sign/sign.gd")

@export var parentIndex: int = TTT_State.mainFieldIndex
@export var index: int
@export var state: TTT_State
@export var cellSize: int = uiSettings.cellSize
var button
var child

func _ready():
	var stateChildType = TTT_State_Selectors.getFieldType(state, index, parentIndex)
	child = _drawChild(stateChildType)

	if _shouldDrawButton(TTT_State_Selectors.getOpenBlock(state), stateChildType): button = _drawButton()

func _enter_tree():
	state.connect("openBlockChanged", _updateOpenBlock)
	state.connect("cellTypeChanged", _updateCellType)
	state.connect("currentPlayerChanged", _handleNewPlayer)

func _exit_tree():
	state.disconnect("openBlockChanged", _updateOpenBlock)
	state.disconnect("cellTypeChanged", _updateCellType)
	state.disconnect("currentPlayerChanged", _handleNewPlayer)

func _handleNewPlayer(_player: int):
	toggleBlock(
		TTT_State_Selectors.getOpenBlock(state),
		TTT_State_Selectors.getFieldType(state, index, parentIndex),
	)

func _updateOpenBlock(openBlock: int):
	toggleBlock(openBlock, TTT_State_Selectors.getFieldType(state, index, parentIndex))

func _updateCellType(updatedCellParentIndex: int, updatedCellIndex: int, newType: TTT_State.FieldType):
	if parentIndex != updatedCellParentIndex || index != updatedCellIndex: return
	toggleChild(newType)

func toggleChild(childType: TTT_State.FieldType):
	if child: remove_child(child)
	child = _drawChild(childType)
	toggleBlock(TTT_State_Selectors.getOpenBlock(state), childType)

func toggleBlock(stateOpenBlock: int, childType: TTT_State.FieldType):
	if _shouldDrawButton(stateOpenBlock, childType):
		if !button:
			button = _drawButton()
	elif button:
		remove_child(button)
		button = null

func _shouldDrawButton(stateOpenBlock: int, childType: TTT_State.FieldType) -> bool:
	if !TTT_State_Selectors.getIsCurrentPlayerActive(state): return false

	# If the current cell is already finished
	if childType == TTT_State.FieldType.x || childType == TTT_State.FieldType.o: return false

	# If the current cell is the top cell and top field is open
	if parentIndex == TTT_State.mainFieldIndex && stateOpenBlock == TTT_State.mainFieldIndex: return true

	# If the current cell is the inner cell and the parent cell is open
	if parentIndex != TTT_State.mainFieldIndex && stateOpenBlock == parentIndex: return true

	return false

func _drawButton():
	var halfCellSize: int = roundi(float(cellSize) / 2)
	var newButton = Button.new()
	newButton.size.x = cellSize
	newButton.size.y = cellSize
	newButton.position.x = -halfCellSize
	newButton.position.y = -halfCellSize
	newButton.pressed.connect(_button_pressed)
	add_child(newButton)
	return newButton

func _drawChild(childType: TTT_State.FieldType):
	var halfCellSize: int = roundi(float(cellSize) / 2)
	var childToDraw = _createChild(childType)
	if (childToDraw):
		add_child(childToDraw)
		childToDraw.position.x = -halfCellSize
		childToDraw.position.y = -halfCellSize
	return childToDraw

func _createChild(childType: TTT_State.FieldType):
	match childType:
		TTT_State.FieldType.x: return _createX()
		TTT_State.FieldType.o: return _createO()
		TTT_State.FieldType.field: return _createGameField()
	return

func _createX() -> TTT_Sign:
	var instance: TTT_Sign = TTT_Sign.new()
	instance.name = "Sign"
	instance.cellSize = cellSize
	instance.value = TTT_State.FieldType.x
	return instance

func _createO() -> TTT_Sign:
	var instance: TTT_Sign = TTT_Sign.new()
	instance.name = "Sign"
	instance.cellSize = cellSize
	instance.value = TTT_State.FieldType.o
	return instance

func _createGameField() -> TTT_Game_Field:
	var instance: TTT_Game_Field = TTT_Game_Field.new()
	instance.state = state
	instance.name = "GameField"
	instance.parentIndex = index
	instance.cellSize = roundi(float(cellSize) / gameSettings.cellNumber)

	return instance

func _button_pressed():
	if (parentIndex == TTT_State.mainFieldIndex):
		state.updateOpenBlock(index)
	else:
		prints('\nplayer')
		state.updateField(index, parentIndex)
