extends Node
class_name GameSettings

signal gameSettingChanged(key: String, newValue: Variant, oldValue: Variant)

const cellNumber: int = 3
const cellNumberForLine: int = 3

enum GameMode {
	vsAI,
	hotSeat,
}

enum GameDifficulty { none, rando, easy, hard, tutorial, medium }

var _config := ConfigFile.new()
var _configFilePath: String = "user://super-tic-tac-toe-config.cfg"
var _configSection: String = "gameSettingChanged"
var _configPassword: String = "super-tic-tac-toe"

var mode: GameMode = GameMode.vsAI
var aiDificulty: GameDifficulty = GameDifficulty.medium
var shouldShowFPS: bool = false
var disableZoom: bool = true
var masterVolume: float = 75
var backgroundVolume: float = 100
var uiVolume: float = 100

var cellSize: int = ProjectSettings.get("display/window/size/viewport_width") / 3
const gameFieldOffset: int = 32
const gameFieldLineWidth: int = 16
const playerXColor: Color = Color(0.8, 0.29, 0.09, 1)  # cb4b16
const playerOColor: Color = Color(0.15, 0.55, 0.82, 1)  # 268bd2
const lineColor: Color = Color(0.4, 0.48, 0.51, 1)  # 667a82
const lineColorActive: Color = Color(0.03, 0.21, 0.26, 1)  # 073642


func _enter_tree():
	_getConfigValue()

	# Set background color
	RenderingServer.set_default_clear_color(Color(0.99, 0.96, 0.89, 1))


func changeSetting(key: String, value: Variant):
	var oldValue = self[key]
	self[key] = value
	emit_signal(gameSettingChanged.get_name(), key, value, oldValue)

	_config.set_value(_configSection, key, value)

	var error = _config.save_encrypted_pass(_configFilePath, _configPassword)
	if error != OK:
		prints("WARN: Cannot save game setting. Error: ", error)


func _getConfigValue():
	var error = _config.load_encrypted_pass(_configFilePath, _configPassword)
	if error != OK:
		prints("WARN: Cannot load game setting. Error: ", error)
		return

	_setValue(
		[
			"mode",
			"aiDificulty",
			"shouldShowFPS",
			"disableZoom",
			"masterVolume",
			"backgroundVolume",
			"uiVolume"
		]
	)


func _setValue(configNames: Array[String]):
	for configName in configNames:
		var defaultValue: Variant = self[configName]
		var rawValue: Variant = _config.get_value(_configSection, configName, defaultValue)
		self[configName] = rawValue if typeof(defaultValue) == typeof(rawValue) else defaultValue
