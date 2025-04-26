local wezterm = require("wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

return tabline.setup({
	options = {
		icons_enabled = true,
		tabs_enabled = true,
		theme = "Catppuccin Mocha",
		theme_overrides = {},
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
	sections = {
		tabline_a = { "mode" },
		tabline_b = { "workspace", icon = wezterm.nerdfonts.cod_terminal_tmux },
		tabline_c = { " " },
		tab_active = {
			{
				"tab", -- the title set in prompt for set title
				icons_enabled = false,
				padding = { left = 1, right = 1 },
			},
		},
		tab_inactive = {
			{
				"tab", -- the title set in prompt for set title
				icons_enabled = false,
				padding = { left = 1, right = 1 },
			},
		},
		tabline_x = {},
		tabline_y = {},
		tabline_z = {
			"domain",
			domain_to_icon = {
				default = wezterm.nerdfonts.cod_terminal_linux,
				ssh = wezterm.nerdfonts.md_ssh,
				wsl = wezterm.nerdfonts.md_microsoft_windows,
				docker = wezterm.nerdfonts.md_docker,
				unix = wezterm.nerdfonts.cod_terminal_linux,
			},
		},
	},
	extensions = {
		"resurrect",
	},
})
