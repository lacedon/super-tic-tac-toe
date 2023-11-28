extends Camera2D
class_name TTT_Camera

@export var state: TTT_State
@export var gameField: Node
@export var animationPlayer: AnimationPlayer
var isCameraZoomedOut: bool = false
var _cellSize: int = gameSettings.cellSize
var zoomSize: float = 3

func _ready():
	# Wait for gameField to be ready
	# Waiting for signal doesn't work by some reason
	await get_tree().create_timer(0.1).timeout
	moveCamera(TTT_State_Selectors.getOpenBlock(state))

func _enter_tree():
	eventEmitter.addListener('toggleCamera', toggleCamera)
	state.connect(state.openBlockChanged.get_name(), moveCamera)
	state.connect(state.restart.get_name(), _handleRestart)

	limit_left = 0
	limit_top = 0
	limit_right = ProjectSettings.get("display/window/size/viewport_width")
	limit_bottom = ProjectSettings.get("display/window/size/viewport_height")

func _exit_tree():
	eventEmitter.removeListener('toggleCamera', toggleCamera)
	state.disconnect(state.openBlockChanged.get_name(), moveCamera)
	state.disconnect(state.restart.get_name(), _handleRestart)

func _handleRestart():
	isCameraZoomedOut = false
	moveCamera(TTT_State_Selectors.getOpenBlock(state))

func toggleCamera():
	isCameraZoomedOut = !isCameraZoomedOut
	moveCamera(TTT_State_Selectors.getOpenBlock(state))

func moveCamera(openBlock: int):
	set_physics_process(true)

	if gameSettings.disableZoom || isCameraZoomedOut || openBlock == TTT_State.mainFieldIndex:
		if zoom.x != 1: animationPlayer.play('zoom-out')
	else:
		if zoom.x == 1:
			animationPlayer.play('zoom-in')
		else:
			animationPlayer.play('zoom-out')
			await animationPlayer.animation_finished
			animationPlayer.play('zoom-in')

		var columnIndex: int = floori(float(openBlock) / gameSettings.cellNumber)
		var rowIndex: int = openBlock - columnIndex * gameSettings.cellNumber
		position = Vector2(columnIndex, rowIndex) * _cellSize + Vector2(_cellSize, _cellSize) / 2

	await animationPlayer.animation_finished
	set_physics_process(false)
