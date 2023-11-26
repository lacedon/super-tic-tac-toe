extends Control

@export var tutorialTextBlock: RichTextLabel
@export var goToMenuButton: Button
@export var state: TTT_State

var preFilledField: Array[TTT_Cell_Resource] = [
	TTT_Cell_Resource.new(TTT_Cell_Resource.FieldType.none),
	TTT_Cell_Resource.new(TTT_Cell_Resource.FieldType.o),
	TTT_Cell_Resource.new(TTT_Cell_Resource.FieldType.o),
	TTT_Cell_Resource.new(TTT_Cell_Resource.FieldType.o),
	TTT_Cell_Resource.new(TTT_Cell_Resource.FieldType.x),
	TTT_Cell_Resource.new(TTT_Cell_Resource.FieldType.x),
	TTT_Cell_Resource.new(TTT_Cell_Resource.FieldType.x),
	TTT_Cell_Resource.new(TTT_Cell_Resource.FieldType.o),
	TTT_Cell_Resource.new(TTT_Cell_Resource.FieldType.x),
]

func _enter_tree():
	gameSettings.changeSetting('aiDificulty', 'tutorial')

func _ready():
	processTutorial()

func _getVerticalPosition(index: int) -> String:
	if index < 3: return 'left'
	elif index < 6: return 'middle'
	else: return 'right'

func _getHorizontalPosition(index: int) -> String:
	var indexModule: int = index % 3
	if indexModule == 0: return 'top'
	elif indexModule == 1: return 'middle'
	else: return 'bottom'

func getPosition(index: int) -> String:
	if index == 4: return 'center'
	return _getVerticalPosition(index) + '-' + _getHorizontalPosition(index)

func processTutorial():
	tutorialTextBlock.text = 'Welcome to Super tic-tac-toe tutorial. Choose one of fields to start the game.';
	# Opened the field
	await state.openBlockChanged

	tutorialTextBlock.text = 'Now choose a cell to put the X there.'
	# Player's move
	await state.cellTypeChanged

	prints('TTT_State_Selectors.getOpenBlock(state)', TTT_State_Selectors.getOpenBlock(state))
	tutorialTextBlock.text = 'You\'ve selected ' + getPosition(TTT_State_Selectors.getOpenBlock(state)) + ' cell. Now your opponent should choose from relevant field.'
	# Bot's move
	await state.cellTypeChanged
	await get_tree().create_timer(1).timeout

	prints('TTT_State_Selectors.getOpenBlock(state)', TTT_State_Selectors.getOpenBlock(state))
	tutorialTextBlock.text = 'It seems like your opponent selected ' + getPosition(TTT_State_Selectors.getOpenBlock(state)) + ', so you have to choose from the relevant field.'

	# Player's move
	await state.cellTypeChanged

	# Bot's move
	await state.cellTypeChanged
	await get_tree().create_timer(1).timeout

	# TODO: Should put here one more step?

	state.fillField(TTT_State_Selectors.getOpenBlock(state), preFilledField)

	tutorialTextBlock.text = 'Now let\'s skip a few steps and move forward. Finish the field.'

	# Player's move
	await state.cellTypeChanged
	tutorialTextBlock.text = 'Hurray! You just won the whole field and put X instead of it.'

	# Bot's move
	await state.cellTypeChanged
	# Player's move
	await state.cellTypeChanged

	tutorialTextBlock.text = 'Win the fields to have 3 X\'s in a row to win the game, and that\'s basicly it.'

	await get_tree().create_timer(10).timeout

	state.finishGame(TTT_State.PlayerSign.x)

	tutorialTextBlock.text = 'Now try to play agains a bot or your friend from the menu menu.'

	await get_tree().create_timer(1).timeout
	anchors_preset = PRESET_FULL_RECT
	tutorialTextBlock.text = 'Here\'s all the rules of the game:
	1. The two players (X and O) take turns, starting with X.
	2. The game starts with X playing wherever they want in any of the 81 empty spots.
	3. The opponent plays, however they are forced to play in the small board indicated by the relative location of the previous move.
	4. If a move is played so that it is to win a small board by the rules of normal tic-tac-toe, then the entire small board is marked as won by the player in the larger board
	5. Once a small board is won by a player or it is filled completely, no more moves may be played on that board. If a player is sent to such a board, then that player may play on any other board.
	6. Game ends when either a player wins the larger board or there are no legal moves remaining, in which case the game is a draw.'
	goToMenuButton.show()
