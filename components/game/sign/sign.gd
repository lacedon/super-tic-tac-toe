extends TextureRect

const spriteX = preload('res://assets/x.svg')
const spriteO = preload('res://assets/o.svg')

@export var value: TTT_Cell_Resource.FieldType
@export var cellSize: int = uiSettings.cellSize
@export var centererByX: bool = false

func _draw():
	expand_mode = EXPAND_FIT_WIDTH
	anchors_preset = PRESET_FULL_RECT
	custom_minimum_size = Vector2(cellSize, cellSize)
	texture = spriteX if value == TTT_Cell_Resource.FieldType.x else spriteO
