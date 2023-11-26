extends Node2D

@export var titleComponent: Label
@export var state: TTT_State
@export var gameField: TTT_Game_Field
@export var changeDifficultyButton: OptionButton
var aiScript: GDScript

var titleText: String = ''

func _ready():
	disableSounds()
	updateDifficulty(gameSettings.aiDificulty)

func _enter_tree():
	titleText = titleComponent.text

	disableAI()

	state.connect(state.cellTypeChanged.get_name(), handleCellTypeChanged)

func _exit_tree():
	state.disconnect(state.cellTypeChanged.get_name(), handleCellTypeChanged)

func disableSounds():
	SoundManager.set_music_volume(0)
	SoundManager.set_sound_volume(0)

func disableAI():
	gameSettings.changeSetting('mode', GameSettings.GameMode.hotSeat)

func updateDifficulty(difficulty: GameSettings.GameDifficulty):
	var difficultyName: String = GameSettings.GameDifficulty.keys()[difficulty]
	gameSettings.changeSetting('aiDificulty', difficulty)
	titleComponent.text = titleText.replace('{Difficulty}', difficultyName)
	aiScript = load('res://components/game/ai/difficulties/' + difficultyName + '.gd')
	drawNumbers()

func handleCellTypeChanged(_parentIndex: int, _index: int, _newType: TTT_Cell_Resource.FieldType):
	drawNumbers()

func drawNumbers():
	var cellsToChoose: Array[int] = aiScript.getCellsToChoose(state, state.openBlock, TTT_State.PlayerSign.o)
	for cellIndex in range(gameField.cells.size()):
		var cellButton = gameField.cells[cellIndex].get_child(1)

		if cellButton:
			cellButton.text = str(cellIndex) if cellsToChoose.has(cellIndex) else ''

func _onChangeDifficultyItemSelected(index: int):
	var difficulty: String = changeDifficultyButton.get_item_text(index)
	updateDifficulty(GameSettings.GameDifficulty[difficulty])

func _onSwitchPlayerPressed():
	state.togglePlayer()

func _onRestartGamePressed():
	state.startGame()
	drawNumbers()
