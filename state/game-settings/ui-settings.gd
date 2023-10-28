extends Node

var cellSize: int = ProjectSettings.get('display/window/size/viewport_width') / 3
const gameFieldOffset: int = 32
const gameFieldLineWidth: int = 16
const playerXColor: Color = Color(0.8, 0.29, 0.09, 1) # cb4b16
const playerOColor: Color = Color(0.15, 0.55, 0.82, 1) # 268bd2
const lineColor: Color = Color(0.03, 0.21, 0.26, 1) # 073642

var lineGradient = null
#: Gradient = (func getGradient():
#	var gradient = Gradient.new()
	# gradient.remove_point(0)
	# gradient.add_point(0, Color(0.35, 0.43, 0.46, 0)) # 586e75
	# gradient.add_point(0.25, Color(0.03, 0.21, 0.26, 1)) # 073642
	# gradient.add_point(0.75, Color(0.03, 0.21, 0.26, 1)) # 073642
	# gradient.add_point(1, Color(0.35, 0.43, 0.46, 0)) # 586e75

# 	gradient.add_point(0, Color(0.03, 0.21, 0.26, 1)) # 073642
# 	gradient.add_point(1, Color(0.03, 0.21, 0.26, 1)) # 073642
# 	return gradient
# ).call()
