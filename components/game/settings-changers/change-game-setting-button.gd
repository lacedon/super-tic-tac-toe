extends Button

@export var settingUpdate: Dictionary

func _enter_tree():
	self.toggle_mode = true

	for propKey in settingUpdate:
		handleGameSettingChanged(propKey, gameSettings[propKey], null)
		break

	connect(pressed.get_name(), setSettingChange)
	gameSettings.connect(gameSettings.gameSettingChanged.get_name(), handleGameSettingChanged)

func _exit_tree():
	disconnect(pressed.get_name(), setSettingChange)
	gameSettings.disconnect(gameSettings.gameSettingChanged.get_name(), handleGameSettingChanged)

func setSettingChange():
	for propKey in settingUpdate:
		var newValue: Variant = !gameSettings[propKey] if typeof(settingUpdate[propKey]) == TYPE_BOOL else settingUpdate[propKey]
		gameSettings.changeSetting(propKey, newValue)

func handleGameSettingChanged(key: String, newValue: Variant, _oldValue: Variant):
	if !_isRelatedSettingChanged(key): return

	if _isAllRelatedSettingChanged(key, newValue):
		self.button_pressed = true
	else:
		self.button_pressed = false

func _isRelatedSettingChanged(key: String) -> bool:
	for propKey in settingUpdate:
		if propKey == key: return true
	return false

func _isAllRelatedSettingChanged(key: String, newValue: Variant) -> bool:
	for propKey in settingUpdate:
		if propKey == key:
			return settingUpdate[propKey] == newValue
		else:
			return propKey in gameSettings && gameSettings[propKey] == settingUpdate[propKey]
	return false
