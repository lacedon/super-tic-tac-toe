extends Slider

@export var settingName: String

func _enter_tree():
	self.value = gameSettings[settingName]

	connect(value_changed.get_name(), setSettingChange)

func _exit_tree():
	disconnect(value_changed.get_name(), setSettingChange)

func setSettingChange(newValue: float):
	gameSettings.changeSetting(settingName, newValue)
