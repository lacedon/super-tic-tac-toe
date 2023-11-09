extends Button

@export var nextScenePath: String
@export var gameSettingModification: Dictionary
# @export var aiDificulty: String
# @export var mode: GameSettings.GameMode

func _enter_tree():
	connect("pressed", changeScene)

func _exit_tree():
	disconnect("pressed", changeScene)

func changeScene():
	for setting in gameSettingModification:
		gameSettings[setting] = gameSettingModification[setting]
	# gameSettings.mode = mode
	# gameSettings.aiDificulty = aiDificulty
	get_tree().change_scene_to_file(nextScenePath)
