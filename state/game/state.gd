extends Node
class_name TTT_State

signal openBlockChanged(openBlock: int)
signal cellTypeChanged(parentIndex: int, index: int, newType: FieldType)
signal currentPlayerChanged(player: PlayerSign)
signal gameOver(winner: PlayerSign, isDraw: bool)

const ControllerCreateFieldList = preload("./controllers/create-field-list.gd")
const ControllerUpdateOpenBlock = preload("./controllers/update-open-block.gd")
const ControllerUpdateField = preload("./controllers/update-field.gd")
const scriptAI = preload("res://components/game/ai/ai.gd")

enum FieldType { none, x, o, field }
enum PlayerSign { x, o }
enum NestingLevel { one, two }

static var mainFieldIndex = -1

@export var workWithGlobalSettings: bool = true
@export var nestingLevel: NestingLevel = NestingLevel.two
@export var currentPlayer: PlayerSign = PlayerSign.x
@export var activePlayers: Array[PlayerSign] = [currentPlayer]
@export var openBlock: int = mainFieldIndex
var prevOpenBlock: int = mainFieldIndex
var isGameOver: bool = false
var fields: Array

func updateOpenBlock(value: int): ControllerUpdateOpenBlock.updateOpenBlock(self, value)
func updateField(index: int, parentIndex: int): ControllerUpdateField.updateField(self, index, parentIndex)

func _enter_tree():
  fields = ControllerCreateFieldList.createEmptyFieldList(
    FieldType.none if nestingLevel == NestingLevel.one else FieldType.field
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
