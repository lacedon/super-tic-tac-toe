extends Control

const Sign = preload('res://components/game/sign/sign.gd')
const signNumber = 10
const minSpeed = 30
const maxSpeed = 100
const stepMax = 20

@export var opacity: float = 0.5

var signs = Array()

func _ready():
	modulate.a = opacity

	for index in range(signNumber):
		var item: Sign = Sign.new()
		item.value = TTT_State.FieldType.x if index % 2 == 0 else TTT_State.FieldType.o

		item.position = Vector2(0, randf() * (size[1] - item.size[1]))

		add_child(item)

		signs.append({
			sign = item,
			step = randf() * stepMax,
			speed = randf() * (maxSpeed - minSpeed) + minSpeed
		})

func _process(delta):
	for item in signs:
		item.step += delta

		var newX: float = (0.5 + 0.5 * sin(item.step)) * (size[0] - item.sign.size[0])
		var newY: float = item.sign.position.y - delta * item.speed

		if newY < -item.sign.size[1]:
			newX = 0
			newY = size[1]
			item.step = randf() * stepMax
 
		item.sign.position = Vector2(newX, newY)
