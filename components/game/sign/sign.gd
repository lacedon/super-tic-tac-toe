extends TextureRect
class_name TTT_Sign

const spriteX = preload('res://assets/x.svg')
const spriteO = preload('res://assets/o.svg')

@export var value: TTT_Cell_Resource.FieldType
@export var cellSize: int = gameSettings.cellSize
@export var centererByX: bool = false

func _ready():
	expand_mode = expand_mode if expand_mode else EXPAND_FIT_WIDTH
	anchors_preset = anchors_preset if anchors_preset else PRESET_FULL_RECT
	custom_minimum_size = custom_minimum_size if custom_minimum_size else Vector2(cellSize, cellSize)

	if value:
		texture = spriteX if value == TTT_Cell_Resource.FieldType.x else spriteO
