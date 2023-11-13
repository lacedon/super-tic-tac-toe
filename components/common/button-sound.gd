extends AudioStreamPlayer2D

@export var pressSound: AudioStream
@export var downSound: AudioStream
@export var upSound: AudioStream

func _enter_tree():
	get_parent().connect('pressed', playPressedSound)
	get_parent().connect('button_down', playDownSound)
	get_parent().connect('button_up', playUpSound)

func _exit_tree():
	get_parent().disconnect('pressed', playPressedSound)
	get_parent().disconnect('button_down', playDownSound)
	get_parent().disconnect('button_up', playUpSound)

func playPressedSound(): if pressSound: SoundManager.play_ui_sound(pressSound)
func playDownSound(): if downSound: SoundManager.play_ui_sound(downSound)
func playUpSound(): if upSound: SoundManager.play_ui_sound(upSound)
