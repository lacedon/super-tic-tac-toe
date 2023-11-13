extends Node

const gameStartedSound = preload('res://assets/game-starts.mp3');

# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.play_ui_sound(gameStartedSound)
