extends Control

func _notification(what: int):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().quit()
