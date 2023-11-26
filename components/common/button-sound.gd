extends AudioStreamPlayer2D

@export var pressSound: AudioStream
@export var downSound: AudioStream
@export var upSound: AudioStream

func _enter_tree():
	var parent: Button = get_parent()
	parent.connect(parent.pressed.get_name(), playPressedSound)
	parent.connect(parent.button_down.get_name(), playDownSound)
	parent.connect(parent.button_up.get_name(), playUpSound)

func _exit_tree():
	var parent: Button = get_parent()
	parent.disconnect(parent.pressed.get_name(), playPressedSound)
	parent.disconnect(parent.button_down.get_name(), playDownSound)
	parent.disconnect(parent.button_up.get_name(), playUpSound)

func playPressedSound(): if pressSound: SoundManager.play_ui_sound(pressSound)
func playDownSound(): if downSound: SoundManager.play_ui_sound(downSound)
func playUpSound(): if upSound: SoundManager.play_ui_sound(upSound)
