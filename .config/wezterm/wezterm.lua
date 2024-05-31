local wezterm = require("wezterm")
local action = wezterm.action

---------------------------- UI -----------------------------------------------
local config = {
	-- $SHELL <- /etc/passwd
	default_prog = { "/bin/zsh", "-l" },
	-- UI color
	color_scheme = "Breeze",
	colors = {
		tab_bar = {
			active_tab = { bg_color = "lightblue", fg_color = "black", italic = true },
			inactive_tab = { bg_color = "lightgray", fg_color = "black", italic = false },
		},
	},

	-- tab bar
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	tab_max_width = 20,
	-- hide_tab_bar_if_only_one_tab = true,
	-- show_new_tab_button_in_tab_bar = false,

	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
	window_decorations = "RESIZE", -- ?

	-- font
	font_size = 11,
	font = wezterm.font_with_fallback({ "JetBrainsMono Nerd Font", "SimHei" }),
}

----------------------- keymaps -----------------------------------------------
config.leader = { mods = "CTRL", key = "s", timeout_milliseconds = 1000 }
config.keys = {
	-- new tab
	{ mods = "LEADER", key = "c", action = action.SpawnTab("CurrentPaneDomain") },
	-- list tabs
	{ mods = "LEADER", key = "w", action = action.ShowTabNavigator },
	-- switch to prev/next tab
	{ mods = "LEADER", key = "n", action = action.ActivateTabRelative(1) },
	{ mods = "LEADER", key = "p", action = action.ActivateTabRelative(-1) },
	-- split window
	{ mods = "LEADER|SHIFT", key = "|", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "-", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- zoom current pane
	{ mods = "LEADER", key = "z", action = action.TogglePaneZoomState },
	-- rename tab
	{
		mods = "LEADER",
		key = "r",
		action = action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}
-- leader + 1~9 switch tab
for i = 1, 9 do
	table.insert(config.keys, { mods = "LEADER", key = tostring(i), action = action.ActivateTab(i - 1) })
end

-- ctrl+hjkl to switch pane / same as in neovim
-- alt+hjkl to resize pane  / same as in neovim
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
	direction_keys = { "h", "j", "k", "l" },
	modifiers = { move = "CTRL", resize = "META" },
})

return config
