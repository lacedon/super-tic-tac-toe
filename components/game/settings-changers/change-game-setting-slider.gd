extends Slider

@export var settingName: String

func _enter_tree():
	self.value = gameSettings[settingName]

	connect("value_changed", setSettingChange)

func _exit_tree():
	disconnect("value_changed", setSettingChange)

func setSettingChange(newValue: float):
	gameSettings.changeSetting(settingName, newValue)
