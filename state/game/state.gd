extends Node
class_name TTT_State

signal openBlockChanged(openBlock: int)
signal cellTypeChanged(parentIndex: int, index: int, newType: TTT_Cell_Resource.FieldType)
signal currentPlayerChanged(player: PlayerSign)
signal gameOver(winner: PlayerSign, isDraw: bool)
signal restart()

const ControllerUpdateOpenBlock = preload("./controllers/update-open-block.gd")
const ControllerUpdateField = preload("./controllers/update-field.gd")
const scriptAI = preload("res://components/game/ai/ai.gd")

enum PlayerSign { x, o }
enum NestingLevel { one, two }

static var mainFieldIndex = -1

@export var workWithGlobalSettings: bool = true
@export var nestingLevel: NestingLevel = NestingLevel.one
@export var currentPlayer: PlayerSign = PlayerSign.x
@export var activePlayers: Array[PlayerSign] = [currentPlayer]
@export var openBlock: int = mainFieldIndex
var prevOpenBlock: int = openBlock
var isGameOver: bool = false
var fields: Array[TTT_Cell_Resource]

func updateOpenBlock(value: int): ControllerUpdateOpenBlock.updateOpenBlock(self, value)
func updateField(index: int, parentIndex: int): ControllerUpdateField.updateField(self, index, parentIndex)

func _enter_tree():
	eventEmitter.addListener('restartGame', startGame)
	startGame()

func _exit_tree():
	eventEmitter.removeListener('restartGame', startGame)

func startGame():
	prints('Restart game')

	openBlock = mainFieldIndex
	prevOpenBlock = mainFieldIndex
	currentPlayer = PlayerSign.x
	isGameOver = false

	fields = TTT_Cell_Resource.createEmptyFieldList(
		TTT_Cell_Resource.FieldType.none if nestingLevel == NestingLevel.one else TTT_Cell_Resource.FieldType.field
	)

	if !workWithGlobalSettings: return

	match gameSettings.mode:
		GameSettings.GameMode.vsAI:
			activePlayers = [PlayerSign.x]

			var ai: TTT_AI = scriptAI.new()
			ai.state = self
			ai.player = PlayerSign.o
			add_child(ai)
		GameSettings.GameMode.hotSeat:
			activePlayers = [PlayerSign.x, PlayerSign.o]

	emit_signal('restart')
