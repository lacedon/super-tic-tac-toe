extends Control

const TTT_Game_Field: Resource = preload("res://components/game/game-field/game-field.gd")
const TTT_Sign: Resource = preload("res://components/game/sign/sign.gd")

var child: Control
var state: TTT_State
var cellSize: int
var index: int
var animationPlayer: = _initAnimationPlayer()
var currentType: TTT_Cell_Resource.FieldType

func _init(
	initState: TTT_State,
	initCellSize: int,
	initIndex: int,
):
	name = 'ChildHelper'
	state = initState
	cellSize = initCellSize
	index = initIndex

func _ready():
	add_child(animationPlayer)

func toggle(childType: TTT_Cell_Resource.FieldType):
	if childType == currentType: return

	currentType = childType
	if child: remove_child(child)
	child = await _createChild(childType)
	if child:
		add_child(child)
		if childType == TTT_Cell_Resource.FieldType.x || childType == TTT_Cell_Resource.FieldType.o:
			animationPlayer.play('scaleIn')
			await animationPlayer.animation_finished

func _createChild(childType: TTT_Cell_Resource.FieldType,):
	var halfCellSize: int = roundi(float(cellSize) / 2)
	var newChild = _createBaseChild(childType)
	if (newChild):
		newChild.position.x = -halfCellSize
		newChild.position.y = -halfCellSize
	return newChild

func _createBaseChild(childType: TTT_Cell_Resource.FieldType):
	match childType:
		TTT_Cell_Resource.FieldType.x: return _createSign(TTT_Cell_Resource.FieldType.x)
		TTT_Cell_Resource.FieldType.o: return _createSign(TTT_Cell_Resource.FieldType.o)
		TTT_Cell_Resource.FieldType.field: return _createGameField()
	return

func _createSign(value: TTT_Cell_Resource.FieldType) -> TTT_Sign:
	var halfCellSize: int = roundi(float(cellSize) / 2)
	var instance: TTT_Sign = TTT_Sign.new()
	instance.name = "Sign"
	instance.cellSize = cellSize
	instance.value = value
	instance.pivot_offset = Vector2(halfCellSize, halfCellSize)
	return instance

func _createGameField() -> TTT_Game_Field:
	var instance: TTT_Game_Field = TTT_Game_Field.new(
		state,
		roundi(float(cellSize) / gameSettings.cellNumber),
		index
	)
	instance.name = "GameField"

	return instance

func _initAnimationPlayer() -> AnimationPlayer:
	var animation: = Animation.new()
	animation.length = 0.2
	animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(0, "Sign:scale")
	animation.track_insert_key(0, 0.0, Vector2(0, 0))
	animation.track_insert_key(0, 0.1, Vector2(1, 1))

	var library: = AnimationLibrary.new()
	library.add_animation('scaleIn', animation)

	var player = AnimationPlayer.new()
	player.add_animation_library('', library)

	return player
