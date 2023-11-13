extends Node

@export var animationPlayer: AnimationPlayer
@export var localCamera: Camera2D
@export var scenes: Array[Control]

func _ready():
	for scene in scenes:
		scene.visible = false

func changeScene(targetScene: String) -> void:
	for scene in scenes:
		scene.position = Vector2.ZERO
		scene.get_material().set_shader_parameter('dimensions', scene.size)
		scene.pivot_offset = scene.size / 2

	var currentCamera = get_viewport().get_camera_2d()
	if currentCamera:
		currentCamera.enabled = false

	animationPlayer.play("xScaleIn")
	await animationPlayer.animation_finished

	get_tree().change_scene_to_file(targetScene)

	animationPlayer.play("oScaleOut")
	await animationPlayer.animation_finished

	var updatedCurrentCamera = get_viewport().get_camera_2d()
	if updatedCurrentCamera:
		updatedCurrentCamera.enabled = true
