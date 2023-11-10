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

func playPressedSound(): _playSound(pressSound)
func playDownSound(): _playSound(downSound)
func playUpSound(): _playSound(upSound)

func _playSound(sound: AudioStream):
	if !sound: return

	stream = sound
	play()
