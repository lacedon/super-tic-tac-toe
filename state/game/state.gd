extends Node
class_name TTT_State

signal openBlockChanged(openBlock: int)
signal cellTypeChanged(parentIndex: int, index: int, newType: TTT_Cell_Resource.FieldType)
signal currentPlayerChanged(player: PlayerSign)
signal gameOver(winner: PlayerSign, isDraw: bool)
signal restart()

const ControllerStartGame = preload("./controllers/start-game.gd")
const ControllerUpdateOpenBlock = preload("./controllers/update-open-block.gd")
const ControllerUpdateField = preload("./controllers/update-field.gd")

enum PlayerSign { x, o }
enum NestingLevel { one, two }

static var mainFieldIndex = -1

@export var workWithGlobalSettings: bool = true
@export var nestingLevel: NestingLevel = NestingLevel.two
@export var currentPlayer: PlayerSign = PlayerSign.x
@export var activePlayers: Array[PlayerSign] = [currentPlayer]
@export var openBlock: int = mainFieldIndex
var prevOpenBlock: int = openBlock
var isGameOver: bool = false
var fields: Array[TTT_Cell_Resource]

func updateOpenBlock(value: int): ControllerUpdateOpenBlock.updateOpenBlock(self, value)
func updateField(index: int, parentIndex: int): ControllerUpdateField.updateField(self, index, parentIndex)
func _startGame(): ControllerStartGame.startGame(self)

func _enter_tree():
	eventEmitter.addListener('restartGame', _startGame)
	_startGame()

func _exit_tree():
	eventEmitter.removeListener('restartGame', _startGame)
