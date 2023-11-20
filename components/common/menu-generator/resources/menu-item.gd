@tool

extends Resource
class_name MenuItem

const MenuList = preload('../menu-generator.gd')

@export var props: Dictionary

func _init(initProps: Dictionary = props):
	props = initProps

func createItem(_menuGenerator: MenuGenerator) -> Control:
	return Control.new()
