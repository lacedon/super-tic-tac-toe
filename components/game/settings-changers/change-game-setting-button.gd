extends Button

@export var settingName: String
var settingValue: Variant

func _enter_tree():
	self.toggle_mode = true

	handleGameSettingChanged(settingName, gameSettings[settingName], null)

	connect("pressed", setSettingChange)
	gameSettings.connect("gameSettingChanged", handleGameSettingChanged)

func _exit_tree():
	disconnect("pressed", setSettingChange)
	gameSettings.disconnect("gameSettingChanged", handleGameSettingChanged)

func setSettingChange():
	gameSettings.changeSetting(settingName, !gameSettings[settingName] if typeof(settingValue) == TYPE_BOOL else settingValue)

func handleGameSettingChanged(key: String, newValue: Variant, _oldValue: Variant):
	if settingName != key: return

	if settingValue == newValue:
		self.button_pressed = true
	else:
		self.button_pressed = false
