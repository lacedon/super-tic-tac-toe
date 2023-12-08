extends Control

const homeScene: String = 'res://scenes/menu/menu.tscn'

func _notification(what: int):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		sceneChanger.changeScene(homeScene)
