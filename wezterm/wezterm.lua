local wezterm = require("wezterm")
local mappings = require("modules.mappings")
local utils = require("modules.utils")
local resurrect = require("plugins.resurrect")

local config = wezterm.config_builder()
require("tabs").setup(config)

return {
	font_size = 16,
	default_cursor_style = "BlinkingBar",
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	line_height = 1.0,
	window_background_opacity = 0.7,
	macos_window_background_blur = 20,
	-- tab bar
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = true,
	tab_max_width = 32,
	colors = {
		tab_bar = {
			background = "rgba(0,0,0,0)",
		},
	},
	show_new_tab_button_in_tab_bar = false,
	unzoom_on_switch_pane = true,
	window_padding = {
		left = "1cell",
		right = "1cell",
		top = "0.5cell",
		bottom = "0.5cell",
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
	keys = utils.merge(mappings.keys, resurrect.keys),
	key_tables = mappings.key_tables,
	font = wezterm.font("FiraCode Nerd Font"),
	font_rules = {
		{
			intensity = "Bold",
			font = wezterm.font("FiraCode Nerd Font", { weight = "Bold" }),
		},
		{
			italic = true,
			intensity = "Half",
			font = wezterm.font("VictorMono Nerd Font", { weight = "DemiLight" }),
		},
		{
			italic = true,
			intensity = "Bold",
			font = wezterm.font("VictorMono Nerd Font", { weight = "DemiBold" }),
		},
	},
	-- taken from https://github.com/folke/tokyonight.nvim/blob/main/extras/wezterm
	color_scheme_dirs = { "./themes" },
	color_scheme = "tokyonight_moon",
}
