extends Control

@export var passStateNodes: Array[Node] = []
@export var state: TTT_State:
	set(value):
		for node in passStateNodes:
			if node:
				node.state = value
