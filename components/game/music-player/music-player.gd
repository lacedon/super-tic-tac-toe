extends Node

const backgroundMusic: AudioStream = preload("res://assets/komiku-bicycle.mp3")
const volumeSettings: Array[String] = ['backgroundVolume', 'uiVolume', 'masterVolume']

func _enter_tree():
	gameSettings.connect('gameSettingChanged', _handleGameSettingChanged)

func _exit_tree():
	gameSettings.disconnect('gameSettingChanged', _handleGameSettingChanged)

func _ready():
	syncVolume()

	SoundManager.play_music(backgroundMusic)

func _getVolume(key: String) -> float:
	var masterVolume: float = gameSettings.masterVolume
	var baseValue: float = gameSettings[key]

	return (masterVolume / 100) * (baseValue / 100)

func syncVolume():
	SoundManager.set_music_volume(_getVolume('backgroundVolume'))
	SoundManager.set_sound_volume(_getVolume('uiVolume'))

	# prints('SoundManager.music.bus', SoundManager.music.bus)
	prints('SoundManager.get_music_volume', SoundManager.get_music_volume())

func _handleGameSettingChanged(key: String, _newValue: Variant, _oldValue: Variant):
	if volumeSettings.has(key): syncVolume()
