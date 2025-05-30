local wezterm = require("wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

-- function to handle falling back to pane title if custom title is not set
local function tab_fmt(text, tab)
	if text == "default" then
		return tab.active_pane.title
	end
	return " " .. text
end

return tabline.setup({
	options = {
		theme = "tokyonight_moon",
		icons_enabled = true,
		tabs_enabled = true,
		section_separators = {
			left = "",
			right = "",
		},
		component_separators = {
			left = "",
			right = "",
		},
		tab_separators = {
			left = "",
			right = "",
		},
	},
	sections = {
		-- tabline_a = { "mode", icon = wezterm.nerdfonts.md_terminal },
		-- tabline_b = { "workspace", icon = wezterm.nerdfonts.cod_terminal_tmux },
		tabline_a = {},
		tabline_b = {},
		tab_active = {
			{
				"tab", -- the title set in prompt for set title
				icons_enabled = true,
				padding = { left = 1, right = 1 },
				fmt = tab_fmt,
			},
		},
		tab_inactive = {
			{
				"tab",
				icons_enabled = true,
				padding = { left = 1, right = 1 },
				fmt = tab_fmt,
			},
		},
		tabline_x = {},
		tabline_y = {
			{
				"hostname",
				icon = wezterm.nerdfonts.md_console_network,
				fmt = function(txt)
					return txt:gsub("ip.", ""):gsub("-", ".")
				end,
			},
		},
		tabline_z = {},
		-- tabline_z = {
		-- 	"domain",
		-- 	domain_to_icon = {
		-- 		default = wezterm.nerdfonts.md_terminal,
		-- 		ssh = wezterm.nerdfonts.md_ssh,
		-- 		wsl = wezterm.nerdfonts.md_microsoft_windows,
		-- 		docker = wezterm.nerdfonts.md_docker,
		-- 		unix = wezterm.nerdfonts.cod_terminal_linux,
		-- 	},
		-- },
	},
	extensions = {
		"resurrect",
	},
})
