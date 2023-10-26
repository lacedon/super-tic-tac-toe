extends Button

func _enter_tree():
	connect("pressed", exit)

func _exit_tree():
	disconnect("pressed", exit)

func exit():
	get_tree().quit()
