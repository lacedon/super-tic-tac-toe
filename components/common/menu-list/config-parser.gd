const MenuItem = preload('./resources/menu-item.gd')
const OpenMenuButton = preload('./button-open-menu.gd')
const CloseMenuButton = preload('./button-close-menu.gd')
const ConfigParser = preload('./config-parser.gd');

static func createNodeFromConfig(config: MenuItem, menu: MenuList, parentMenu: Node, previousMenu: MenuList) -> Node:
	match config.type:
		MenuItem.MenuItemType.title:
			var label = Label.new()
			label.add_theme_font_size_override('font_size', 80)
			label.text = config.text
			return label

		MenuItem.MenuItemType.label:
			var label = Label.new()
			label.text = config.text
			return label

		MenuItem.MenuItemType.button:
			var button = Button.new()
			button.text = config.text
			button.custom_minimum_size = config.size
			if config.scriptPath:
				button.set_script(config.scriptPath)
			if config.props:
				for propName in config.props:
					button[propName] = config.props[propName]
			if config.styles:
				var buttonThemable = ButtonStyler.new()
				buttonThemable.mode = config.styles.mode
				buttonThemable.direction = config.styles.direction
				button.add_child(buttonThemable)
			return button

		MenuItem.MenuItemType.innerMenu:
			var button = OpenMenuButton.new()
			button.text = config.text
			button.menu = config.innerMenu
			button.parentMenu = parentMenu
			button.previousMenu = menu
			button.custom_minimum_size = config.size
			if config.styles:
				var buttonThemable = ButtonStyler.new()
				buttonThemable.mode = config.styles.mode
				buttonThemable.direction = config.styles.direction
				button.add_child(buttonThemable)
			return button

		MenuItem.MenuItemType.closeMenu:
			var button = CloseMenuButton.new()
			button.text = config.text
			button.menu = menu
			button.parentMenu = parentMenu
			button.previousMenu = previousMenu
			button.custom_minimum_size = config.size
			if config.styles:
				var buttonThemable = ButtonStyler.new()
				buttonThemable.mode = config.styles.mode
				buttonThemable.direction = config.styles.direction
				button.add_child(buttonThemable)
			return button

		MenuItem.MenuItemType.spacer:
			var spacer = VSplitContainer.new()

			if config.size == Vector2.ZERO:
				spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			else:
				spacer.custom_minimum_size = config.size

			return spacer

	return Node.new()
