static func updateCameraBlock(state: TTT_State, value: int):
	print('> updateCameraBlock[', value, ']')
	state.cameraBlock = value
	state.emit_signal("cameraBlockChanged", value)
