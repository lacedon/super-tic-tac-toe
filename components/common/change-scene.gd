extends Button

@export var nextScenePath: String
@export var gameSettingModification: Dictionary

func _enter_tree():
	connect(pressed.get_name(), changeScene)

func _exit_tree():
	disconnect(pressed.get_name(), changeScene)

func changeScene():
	for setting in gameSettingModification:
		gameSettings[setting] = gameSettingModification[setting]
	sceneChanger.changeScene(nextScenePath)
