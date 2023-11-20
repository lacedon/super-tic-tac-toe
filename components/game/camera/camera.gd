extends Camera2D
class_name TTT_Camera

@export var state: TTT_State
@export var gameField: Node
var isCameraZoomedOut: bool = false
var _cellSize: int = gameSettings.cellSize
var zoomSize: float = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	position_smoothing_enabled = true
	_setLimits()

	moveCamera(TTT_State_Selectors.getOpenBlock(state))

func _enter_tree():
	eventEmitter.addListener('toggleCamera', toggleCamera)
	state.connect("openBlockChanged", moveCamera)
	state.connect("restart", _handleRestart)

func _exit_tree():
	eventEmitter.removeListener('toggleCamera', toggleCamera)
	state.disconnect("openBlockChanged", moveCamera)
	state.disconnect("restart", _handleRestart)

func _handleRestart():
	isCameraZoomedOut = false
	moveCamera(TTT_State_Selectors.getOpenBlock(state))

func _setLimits():
	offset = -gameField.position

func toggleCamera():
	isCameraZoomedOut = !isCameraZoomedOut
	moveCamera(TTT_State_Selectors.getOpenBlock(state))

func moveCamera(openBlock: int):
	set_physics_process(true)

	if gameSettings.disableZoom || isCameraZoomedOut || openBlock == TTT_State.mainFieldIndex:
		zoom = Vector2(1, 1)
		offset = Vector2.ZERO
		position = Vector2.ZERO
	else:
		offset = -gameField.position / gameSettings.cellNumber
		zoom = Vector2(zoomSize, zoomSize)

		var blockIndex: int = floori(float(openBlock) / gameSettings.cellNumber)
		position = gameField.position + Vector2(
			(blockIndex) * _cellSize,
			(openBlock - blockIndex * gameSettings.cellNumber) * _cellSize,
		)

	set_physics_process(false)
