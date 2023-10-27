const OpenMenuButton = preload('./button-open-menu.gd')
const CloseMenuButton = preload('./button-close-menu.gd')
const ConfigParser = preload('./config-parser.gd');

static func createNodeFromConfig(config: Dictionary, menu: MenuList, parentMenu: Node, previousMenu: MenuList) -> Node:
	match config.type:
		'title':
			var label = Label.new()
			label.text = config.text
			return label
		'button':
			var button = Button.new()
			button.text = config.text
			if 'size' in config:
				button.custom_minimum_size = Vector2(
					config.size[0] if config.size.size() > 1 && config.size[0] else 0,
					config.size[1] if config.size.size() > 2 && config.size[1] else 0,
				)
			if 'script' in config:
				button.set_script(load(config.script))
			if 'props' in config:
				for propName in config.props:
					button[propName] = config.props[propName]
			if 'styles' in config:
				var buttonThemable = ButtonStyler.new()
				buttonThemable.mode = config.styles.mode
				buttonThemable.direction = config.styles.direction
				button.add_child(buttonThemable)

			return button
		'innerMenu':
			var button = OpenMenuButton.new()
			button.text = config.text
			button.menuJSON = config.innerMenu
			button.parentMenu = parentMenu
			button.previousMenu = menu
			if 'styles' in config:
				var buttonThemable = ButtonStyler.new()
				buttonThemable.mode = config.styles.mode
				buttonThemable.direction = config.styles.direction
				button.add_child(buttonThemable)

			return button
		'closeMenu':
			var button = CloseMenuButton.new()
			button.text = config.text
			button.menu = menu
			button.parentMenu = parentMenu
			button.previousMenu = previousMenu
			if 'styles' in config:
				var buttonThemable = ButtonStyler.new()
				buttonThemable.mode = config.styles.mode
				buttonThemable.direction = config.styles.direction
				button.add_child(buttonThemable)

			return button
	return Node.new()