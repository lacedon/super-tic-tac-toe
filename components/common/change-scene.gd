extends Button

@export var nextScenePath: String
@export var gameSettingModification: Dictionary

func _enter_tree():
	connect("pressed", changeScene)

func _exit_tree():
	disconnect("pressed", changeScene)

func changeScene():
	for setting in gameSettingModification:
		gameSettings[setting] = gameSettingModification[setting]
	sceneChanger.changeScene(nextScenePath)
