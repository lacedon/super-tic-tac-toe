extends Control

@export var state: TTT_State
@export var passStateNodes: Array[Node] = []

func _enter_tree():
	for node in passStateNodes:
		if node:
			node.state = state
