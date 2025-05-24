local wezterm = require("wezterm")
local act = wezterm.action

local mappings = {
	leader = {
		key = "Space",
		mods = "SHIFT",
		timeout_milliseconds = 2000,
	},

	keys = {
		{
			key = "w",
			mods = "CMD",
			action = act.CloseCurrentPane({
				confirm = true,
			}),
		}, -- activate resize mode
		{
			key = "r",
			mods = "LEADER",
			action = act.ActivateKeyTable({
				name = "resize_pane",
				one_shot = false,
			}),
		}, -- focus panes
		{
			key = "h",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Down"),
		}, -- add new panes
		{
			key = "J",
			mods = "LEADER",
			action = act.SplitVertical({
				domain = "CurrentPaneDomain",
			}),
		},
		{
			key = "L",
			mods = "LEADER",
			action = act.SplitHorizontal({
				domain = "CurrentPaneDomain",
			}),
		},
		{
			key = ",",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		{
			key = "f",
			mods = "LEADER",
			action = act.TogglePaneZoomState,
		},
		{
			key = "s",
			mods = "LEADER",
			action = act.PaneSelect({
				mode = "SwapWithActiveKeepFocus",
			}),
		},
		{
			key = "A",
			mods = "LEADER",
			action = act.AttachDomain("unix"),
		},
		-- Detach from muxer
		{
			key = "Z",
			mods = "LEADER",
			action = act.DetachDomain({ DomainName = "unix" }),
		},
		{
			key = "W",
			mods = "LEADER",
			action = act.ShowLauncherArgs({
				flags = "FUZZY|WORKSPACES",
			}),
		},
		-- Workspace switch bindings
		{ key = "w", mods = "LEADER", action = act.SwitchWorkspaceRelative(1) },
		{ key = "q", mods = "LEADER", action = act.SwitchWorkspaceRelative(-1) },
		-- Rename current workspace
		{
			key = "R",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Rename current workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						wezterm.mux.rename_workspace(window:mux_window():get_workspace(), line)
					end
				end),
			}),
		},
		-- Prompt for a name to use for a new workspace and switch to it.
		{
			key = "Q",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter name for new workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:perform_action(
							act.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},
	},

	key_tables = {
		resize_pane = {
			{
				key = "LeftArrow",
				action = act.AdjustPaneSize({ "Left", 5 }),
			},
			{
				key = "h",
				action = act.AdjustPaneSize({ "Left", 5 }),
			},
			{
				key = "RightArrow",
				action = act.AdjustPaneSize({ "Right", 5 }),
			},
			{
				key = "l",
				action = act.AdjustPaneSize({ "Right", 5 }),
			},
			{
				key = "UpArrow",
				action = act.AdjustPaneSize({ "Up", 2 }),
			},
			{
				key = "k",
				action = act.AdjustPaneSize({ "Up", 2 }),
			},
			{
				key = "DownArrow",
				action = act.AdjustPaneSize({ "Down", 2 }),
			},
			{
				key = "j",
				action = act.AdjustPaneSize({ "Down", 2 }),
			},
			{
				key = "Escape",
				action = "PopKeyTable",
			},
		},
	},
}

for i = 1, 8 do
	-- CTRL+ALT + number to move to that position
	table.insert(mappings.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.MoveTab(i - 1),
	})
end

return mappings
