local wezterm = require("wezterm") --[[@as Wezterm]]

local M = {}
M.arrow_solid = ""
M.arrow_thin = ""
M.icons = {
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["btm"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["curl"] = wezterm.nerdfonts.mdi_flattr,
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["fish"] = wezterm.nerdfonts.md_fish,
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["git"] = wezterm.nerdfonts.dev_git,
	["go"] = wezterm.nerdfonts.seti_go,
	["htop"] = wezterm.nerdfonts.md_chart_areaspline,
	["btop"] = wezterm.nerdfonts.md_chart_areaspline,
	["kubectl"] = wezterm.nerdfonts.linux_docker,
	["lazykube"] = wezterm.nerdfonts.linux_docker,
	["kuberlr"] = wezterm.nerdfonts.linux_docker,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["make"] = wezterm.nerdfonts.seti_makefile,
	["node"] = wezterm.nerdfonts.mdi_hexagon,
	["nvim"] = wezterm.nerdfonts.custom_vim,
	["pacman"] = "󰮯 ",
	["paru"] = "󰮯 ",
	["psql"] = wezterm.nerdfonts.dev_postgresql,
	["pwsh.exe"] = wezterm.nerdfonts.md_console,
	["ruby"] = wezterm.nerdfonts.cod_ruby,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["vim"] = wezterm.nerdfonts.dev_vim,
	["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
	["zsh"] = wezterm.nerdfonts.dev_terminal,
	["lazygit"] = wezterm.nerdfonts.cod_github,
}

---@param tab MuxTabObj
---@param max_width number
function M.title(tab, max_width)
	local title = (tab.tab_title and #tab.tab_title > 0) and tab.tab_title or tab.active_pane.title
	local process, other = title:match("^(%S+)%s*%-?%s*%s*(.*)$")

	if M.icons[process] then
		title = M.icons[process] .. " " .. (other or "")
	end

	local is_zoomed = false
	for _, pane in ipairs(tab.panes) do
		if pane.is_zoomed then
			is_zoomed = true
			break
		end
	end
	if is_zoomed then -- or (#tab.panes > 1 and not tab.is_active) then
		title = "󰋲 " .. title
	end

	title = wezterm.truncate_right(title, max_width - 3)
	return " " .. title .. " "
end

---@param config Config
function M.setup(config)
	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local title = M.title(tab, max_width)
		local colors = config.resolved_palette
		local active_bg = "none"
		local inactive_bg = "none"

		local tab_idx = 1
		for i, t in ipairs(tabs) do
			if t.tab_id == tab.tab_id then
				tab_idx = i
				break
			end
		end
		local is_last = tab_idx == #tabs
		local next_tab = tabs[tab_idx + 1]
		local next_is_active = next_tab and next_tab.is_active
		local arrow = M.arrow_thin
		local arrow_bg = "none"
		local arrow_fg = colors.tab_bar.inactive_tab_edge

		arrow_fg = colors.tab_bar.inactive_tab.fg_color
		arrow_bg = "none"

		local ret = tab.is_active and {
			{ Foreground = { Color = "#c8d3f5" } },
		} or {}
		ret[#ret + 1] = { Background = { Color = "none" } }
		ret[#ret + 1] = { Text = title }
		ret[#ret + 1] = { Foreground = { Color = arrow_fg } }
		ret[#ret + 1] = { Background = { Color = arrow_bg } }
		ret[#ret + 1] = { Text = arrow }
		return ret
	end)
end

return M
