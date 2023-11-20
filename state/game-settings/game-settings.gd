extends Node
class_name GameSettings

signal gameSettingChanged(key: String, newValue: Variant, oldValue: Variant)

const cellNumber: int = 3
const cellNumberForLine: int = 3

enum GameMode {
	vsAI,
	hotSeat,
}

var mode: GameMode = GameMode.vsAI
var aiDificulty: String = 'easy'
var shouldShowFPS: bool = true
var disableZoom: bool = false
var masterVolume: float = 75
var backgroundVolume: float = 100
var uiVolume: float = 100

var cellSize: int = ProjectSettings.get('display/window/size/viewport_width') / 3
const gameFieldOffset: int = 32
const gameFieldLineWidth: int = 16
const playerXColor: Color = Color(0.8, 0.29, 0.09, 1) # cb4b16
const playerOColor: Color = Color(0.15, 0.55, 0.82, 1) # 268bd2
const lineColor: Color = Color(0.4, 0.48, 0.51, 1) # 667a82
const lineColorActive: Color = Color(0.03, 0.21, 0.26, 1) # 073642

func _ready():

	# Set background color
	RenderingServer.set_default_clear_color(Color(0.99, 0.96, 0.89, 1))

func changeSetting(key: String, value: Variant):
	var oldValue = self[key]
	self[key] = value
	emit_signal('gameSettingChanged', key, value, oldValue)
