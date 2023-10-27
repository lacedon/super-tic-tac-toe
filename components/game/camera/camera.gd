extends Camera2D
class_name TTT_Camera


@export var state: TTT_State
var _cellSize: int = uiSettings.cellSize

# Called when the node enters the scene tree for the first time.
func _ready():
	anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	position_smoothing_enabled = true
	_setLimits()

	moveCamera(TTT_State_Selectors.getOpenBlock(state))

func _enter_tree():
	state.connect("openBlockChanged", moveCamera)

func _exit_tree():
	state.disconnect("openBlockChanged", moveCamera)

func _setLimits():
	limit_left = 0
	limit_right = _cellSize * gameSettings.cellNumber
	limit_top = 0
	limit_bottom = _cellSize * gameSettings.cellNumber

func moveCamera(newOpenBlock: int):
	set_physics_process(true)

	if newOpenBlock == TTT_State.mainFieldIndex:
		zoom = Vector2(1, 1)
		position = Vector2.ZERO
	else:
		zoom = Vector2(gameSettings.cellNumber, gameSettings.cellNumber)

		# TODO: Refactor to keep behaviour with rounding, but get rid of the warning
		position = Vector2(
			(newOpenBlock / gameSettings.cellNumber) * _cellSize,
			(newOpenBlock - newOpenBlock / gameSettings.cellNumber * gameSettings.cellNumber) * _cellSize,
		)

		set_physics_process(false)
