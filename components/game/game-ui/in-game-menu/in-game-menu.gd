extends Control

@export var animationPlayer: AnimationPlayer

func _enter_tree():
	eventEmitter.addListener("toggleInGameMenu", toggleVisibility)

func _exit_tree():
	eventEmitter.removeListener("toggleInGameMenu", toggleVisibility)

func toggleVisibility():
	if self.visible:
		animationPlayer.play_backwards('open')
		await animationPlayer.animation_finished
		self.hide()
	else:
		self.show()
		animationPlayer.play('open')
		await animationPlayer.animation_finished
