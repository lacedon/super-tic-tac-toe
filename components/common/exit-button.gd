extends Button

func _enter_tree():
	connect(pressed.get_name(), exit)

func _exit_tree():
	disconnect(pressed.get_name(), exit)

func exit():
	get_tree().quit()
