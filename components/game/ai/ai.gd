extends Node
class_name TTT_AI

const difficultiesRando = preload('./difficulties/rando.gd')
const difficultiesEasy = preload('./difficulties/easy.gd')
const difficultiesHard = preload('./difficulties/hard.gd')
const difficultiesTutorial = preload('./difficulties/tutorial.gd')

@export var state: TTT_State
@export var player: TTT_State.PlayerSign = TTT_State.PlayerSign.o
var _difficultyImplementation = _getDifficultyImplementation()

func _ready():
	randomize()

func _enter_tree():
	state.connect(state.currentPlayerChanged.get_name(), _initTurnAction)
	state.connect(state.statusChanged.get_name(), _handleStatusChanged)

func _exit_tree():
	state.disconnect(state.currentPlayerChanged.get_name(), _initTurnAction)
	state.disconnect(state.statusChanged.get_name(), _handleStatusChanged)

func _initTurnAction(newPlayer: int):
	if !TTT_State_Selectors.getIsGameRunning(state): return
	if TTT_State_Selectors.getIsGameOver(state): return
	if player != newPlayer: return
	makeTurn()

func _handleStatusChanged(_newStatus: TTT_State.GameStatus):
	prints('TTT_State_Selectors.getIsGameRunning(state)', TTT_State_Selectors.getIsGameRunning(state))
	prints('TTT_State_Selectors.getIsGameOver(state)', TTT_State_Selectors.getIsGameOver(state))
	prints('TTT_State_Selectors.getCurrentPlayer(state)', TTT_State_Selectors.getCurrentPlayer(state))
	prints('player', player)

	if !TTT_State_Selectors.getIsGameRunning(state): return
	if TTT_State_Selectors.getIsGameOver(state): return
	if player != TTT_State_Selectors.getCurrentPlayer(state): return
	makeTurn()

func makeTurn():
	await _getTimeout()

	var openBlock: int = TTT_State_Selectors.getOpenBlock(state)
	var cellsToChoose: Array[int] = _difficultyImplementation.getCellsToChoose(state, openBlock, player)
	var cellIndex: int = _selectCell(cellsToChoose)
	var cellType: TTT_Cell_Resource.FieldType = TTT_State_Selectors.getFieldType(state, cellIndex, openBlock)
	if cellType == TTT_Cell_Resource.FieldType.field:
		state.updateOpenBlock(cellIndex)
		openBlock = cellIndex
		makeTurn()
	else:
		state.updateField(cellIndex, openBlock)

func _selectCell(cellsToChoose: Array[int]) -> int:
	return cellsToChoose.pick_random()

func _getTimeout():
	return get_tree().create_timer(0.03).timeout

func _getDifficultyImplementation():
	match gameSettings.aiDificulty:
		GameSettings.GameDifficulty.rando: return difficultiesRando
		GameSettings.GameDifficulty.easy: return difficultiesEasy
		GameSettings.GameDifficulty.hard: return difficultiesHard
		GameSettings.GameDifficulty.tutorial: return difficultiesTutorial
	return difficultiesEasy
