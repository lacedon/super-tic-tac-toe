extends Node
class_name TTT_State

signal openBlockChanged(openBlock: int)
signal cellTypeChanged(parentIndex: int, index: int, newType: TTT_Cell_Resource.FieldType)
signal fieldChanged()
signal currentPlayerChanged(player: PlayerSign)
signal gameOver(winner: PlayerSign, isDraw: bool)
signal restart()
signal turnMade()

const ControllerFillField = preload("./controllers/fill-field.gd")
const ControllerFinishGame = preload("./controllers/finish-game.gd")
const ControllerStartGame = preload("./controllers/start-game.gd")
const ControllerUpdateOpenBlock = preload("./controllers/update-open-block.gd")
const ControllerUpdateField = preload("./controllers/update-field.gd")
const ControllerUpdatePlayer = preload("./controllers/update-player.gd")

enum PlayerSign { x, o }
enum NestingLevel { one, two }

static var mainFieldIndex = -1

@export var workWithGlobalSettings: bool = true
@export var nestingLevel: NestingLevel = NestingLevel.two
@export var currentPlayer: PlayerSign = PlayerSign.x
@export var activePlayers: Array[PlayerSign] = [currentPlayer]
@export var openBlock: int = mainFieldIndex
@export var rewrittenAiDifficulty: GameSettings.GameDifficulty = GameSettings.GameDifficulty.none
var prevOpenBlock: int = openBlock
var isGameOver: bool = false
var fields: Array[TTT_Cell_Resource]

func updateOpenBlock(value: int): ControllerUpdateOpenBlock.updateOpenBlock(self, value)
func updateField(index: int, parentIndex: int): ControllerUpdateField.updateField(self, index, parentIndex)
func togglePlayer(): ControllerUpdatePlayer.togglePlayer(self, true, PlayerSign.x)
func startGame(): ControllerStartGame.startGame(self)
func finishGame(winner: PlayerSign, isDraw: bool = false): ControllerFinishGame.finishGame(self, winner, isDraw)
func fillField(parentIndex: int, value: Array[TTT_Cell_Resource]): ControllerFillField.fillField(self, parentIndex, value)
func makeTurn(): emit_signal(turnMade.get_name())

func _enter_tree():
	eventEmitter.addListener('restartGame', startGame)
	startGame()

func _exit_tree():
	eventEmitter.removeListener('restartGame', startGame)
