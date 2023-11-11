extends Node

const backgroundMusic = preload("res://assets/komiku-bicycle.mp3")

var cellSize: int = ProjectSettings.get('display/window/size/viewport_width') / 3
const gameFieldOffset: int = 32
const gameFieldLineWidth: int = 16
const playerXColor: Color = Color(0.8, 0.29, 0.09, 1) # cb4b16
const playerOColor: Color = Color(0.15, 0.55, 0.82, 1) # 268bd2
const lineColor: Color = Color(0.4, 0.48, 0.51, 1) # 667a82
const lineColorActive: Color = Color(0.03, 0.21, 0.26, 1) # 073642
const backgroundMusicVolume: float = 0.5
const uiMusicVolume: float = 0.5

func _ready():
	SoundManager.set_music_volume(backgroundMusicVolume)
	SoundManager.set_sound_volume(uiMusicVolume)

	RenderingServer.set_default_clear_color(Color(0.99, 0.96, 0.89, 1))
	SoundManager.play_music_at_volume(backgroundMusic)
