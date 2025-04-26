local wezterm = require("wezterm")
local mappings = require("modules.mappings")
local merge = require("modules.utils")
local resurrect = require("plugins.resurrect")

require("plugins.tabline")

return {
	default_cursor_style = "BlinkingBlock",
	color_scheme = "Poimandres",
	colors = {
		cursor_bg = "#A6ACCD",
		cursor_border = "#A6ACCD",
		cursor_fg = "#1B1E28",
		compose_cursor = "orange",
	},
	-- font
	font = wezterm.font("FiraCode Nerd Font Mono", {
		weight = "Medium",
	}),
	font_size = 15,
	line_height = 1,
	window_background_opacity = 0.9,
	macos_window_background_blur = 20,
	-- tab bar
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = false,
	hide_tab_bar_if_only_one_tab = false,
	tab_max_width = 999999,
	window_padding = {
		left = 20,
		right = 20,
		top = 15,
		bottom = 0,
	},
	window_decorations = "RESIZE",
	inactive_pane_hsb = {
		brightness = 0.7,
	},
	notification_handling = "AlwaysShow",
	send_composed_key_when_left_alt_is_pressed = false,
	send_composed_key_when_right_alt_is_pressed = true,
	-- key bindings
	leader = mappings.leader,
	keys = merge.all(mappings.keys, resurrect.keys),
	key_tables = mappings.key_tables,
}
