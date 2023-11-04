extends Camera2D
class_name TTT_Camera


@export var state: TTT_State
@export var gameField: Node
var _cellSize: int = uiSettings.cellSize
var zoomSize: float = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	position_smoothing_enabled = true
	_setLimits()

	moveCamera(TTT_State_Selectors.getCameraBlock(state))

func _enter_tree():
	state.connect("cameraBlockChanged", moveCamera)

func _exit_tree():
	state.disconnect("cameraBlockChanged", moveCamera)

func _setLimits():
	offset = -gameField.position

func moveCamera(newOpenBlock: int):
	set_physics_process(true)

	var cameraBlock: int = TTT_State_Selectors.getOpenBlock(state) if newOpenBlock == TTT_State.cameraDisabledIndex else newOpenBlock

	if cameraBlock == TTT_State.mainFieldIndex:
		zoom = Vector2(1, 1)
		offset = Vector2.ZERO
		position = Vector2.ZERO
	else:
		offset = -gameField.position / gameSettings.cellNumber
		zoom = Vector2(zoomSize, zoomSize)

		var blockIndex: int = floori(float(cameraBlock) / gameSettings.cellNumber)
		position = gameField.position + Vector2(
			(blockIndex) * _cellSize,
			(cameraBlock - blockIndex * gameSettings.cellNumber) * _cellSize,
		)

	set_physics_process(false)
