extends Control
class_name BubbleAnimation

# const Sign = preload('res://components/game/sign/sign.gd')
const itemNumber: int = 10
const minSpeed: int = 30
const maxSpeed: int = 100
const stepMax: int = 100

@export var opacity: float = 0.5
@export var ItemCreator: Resource

var items: Array = Array()

func _ready():
	modulate.a = opacity

	for index in range(itemNumber):
		var item: Node = ItemCreator.new()
		item.value = TTT_Cell_Resource.FieldType.x if index % 2 == 0 else TTT_Cell_Resource.FieldType.o

		item.position = Vector2(0, randf() * (size[1] - item.size[1]))

		add_child(item)

		items.append({
			sign = item,
			step = randf() * stepMax,
			speed = randf() * (maxSpeed - minSpeed) + minSpeed
		})

func _process(delta):
	for item in items:
		item.step += delta

		var newX: float = (0.5 + 0.5 * sin(item.step)) * (size[0] - item.sign.size[0])
		var newY: float = item.sign.position.y - delta * item.speed

		if newY < -item.sign.size[1]:
			newX = 0
			newY = size[1]
			item.step = randf() * stepMax
 
		item.sign.position = Vector2(newX, newY)
