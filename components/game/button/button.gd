extends Button
class_name TTTButton

enum BackgroundOrientation {
	horizontal,
	vertical,
}

@export var lineWidth: int = 24
@export var orientation: BackgroundOrientation = BackgroundOrientation.vertical
@export var margin: int = 4
# var _halfWidth: int = roundi(float(lineWidth) / 2)
# var _doubleWidth: int = lineWidth * 2

# Called when the node enters the scene tree for the first time.
func _ready():
	print('TEST BUTTON', text)

	# var textLine = Label.new()
	# textLine.text = self.text

	var marginComponent = MarginContainer.new()
	self.add_theme_constant_override('margin_left', margin)
	self.add_theme_constant_override('margin_right', margin)
	# marginComponent.add_child(textLine)

	add_child(marginComponent)

	self.text = ''

# func createLine():
# 	var backgroundLine = Line2D.new()
# 	backgroundLine.width = lineWidth
# 	backgroundLine.joint_mode = Line2D.LINE_JOINT_ROUND
# 	backgroundLine.begin_cap_mode = Line2D.LINE_CAP_ROUND
# 	backgroundLine.end_cap_mode = Line2D.LINE_CAP_ROUND
# 	backgroundLine.z_index = -1

# 	var isHorizontal = orientation == BackgroundOrientation.horizontal
# 	var cellSize: float = self.size.x if isHorizontal else self.size.y
# 	var pointNumber: int = roundi(cellSize / lineWidth)

# 	for index in range(pointNumber):
# 		var baseX: int = index * lineWidth if isHorizontal else roundi((index % 2) * cellSize)
# 		var baseY: int = roundi((index % 2) * cellSize) if isHorizontal else index * lineWidth

# 		backgroundLine.add_point(Vector2(
# 			baseX + (_halfWidth if isHorizontal else _doubleWidth) * (randf() - 0.5),
# 			baseY + (_doubleWidth if isHorizontal else _halfWidth) * (randf() - 0.5),
# 		))

# 	return backgroundLine
