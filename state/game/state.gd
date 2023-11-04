extends Node
class_name TTT_State

signal openBlockChanged(openBlock: int)
signal cameraBlockChanged(cameraBlock: int)
signal cellTypeChanged(parentIndex: int, index: int, newType: TTT_Cell_Resource.FieldType)
signal currentPlayerChanged(player: PlayerSign)
signal gameOver(winner: PlayerSign, isDraw: bool)

const ControllerUpdateOpenBlock = preload("./controllers/update-open-block.gd")
const ControllerUpdateCameraBlock = preload("./controllers/update-camera-block.gd")
const ControllerUpdateField = preload("./controllers/update-field.gd")
const scriptAI = preload("res://components/game/ai/ai.gd")

enum PlayerSign { x, o }
enum NestingLevel { one, two }

static var mainFieldIndex = -1
static var cameraDisabledIndex = -2

@export var workWithGlobalSettings: bool = true
@export var nestingLevel: NestingLevel = NestingLevel.two
@export var currentPlayer: PlayerSign = PlayerSign.x
@export var activePlayers: Array[PlayerSign] = [currentPlayer]
@export var openBlock: int = mainFieldIndex
var cameraBlock: int = cameraDisabledIndex
var prevOpenBlock: int = openBlock
var isGameOver: bool = false
var fields: Array[TTT_Cell_Resource]

func updateOpenBlock(value: int): ControllerUpdateOpenBlock.updateOpenBlock(self, value)
func updateCameraBlock(value: int): ControllerUpdateCameraBlock.updateCameraBlock(self, value)
func updateField(index: int, parentIndex: int): ControllerUpdateField.updateField(self, index, parentIndex)

func _enter_tree():
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
