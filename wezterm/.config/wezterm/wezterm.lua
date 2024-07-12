-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Change the default ssh backend from 'Libssh' to 'Ssh2'. Needed for WM.
config.ssh_backend = "Ssh2"

-- This is where you actually apply your config choices
config.color_scheme = "Gruvbox Dark (Gogh)"
-- config.color_scheme = "Catppuccin Macchiato" -- Mocha, Macchiato, Frappe, Latte

-- config.font = wezterm.font 'UbuntuMono Nerd Font Mono'
-- Some other nice fonts:
config.font = wezterm.font("InputMono")
-- config.font = wezterm.font 'JetbrainsMono Nerd Font Mono'
-- config.font_size = 11.0 -- Default is 12.00 - for UbuntuMono set to 11
config.font_size = 10.0 -- Default is 12.00
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
	-- The font used in the tab bar.
	-- Roboto Bold is the default; this font is bundled
	-- with wezterm.
	-- Whatever font is selected here, it will have the
	-- main font setting appended to it to pick up any
	-- fallback fonts you may have used there.
	-- font = wezterm.font { family = 'UbuntuMono', weight = 'Bold' },
	-- Some other nice fonts:
	font = wezterm.font({ family = "InputMono", weight = "Bold" }),
	-- font = wezterm.font { family = 'JetbrainsMono', weight = 'Bold' },

	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems - for UbuntuMono set to 11
	font_size = 10.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#333333",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "#333333",
}

config.colors = {
	tab_bar = {
		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = "#8fce00",
	},
}

-- Set "CTRL-a" as LEADER
-- config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
--
-- Set "CapsLock" as LEADER - use `setxkbmap -option caps:none` in your terminal or .zshrc
config.leader = { key = "VoidSymbol", mods = "", timeout_milliseconds = 1000 }
config.keys = {
	-- Send LEADER-a when pressing LEADER-a twice
	{ key = "a", mods = "LEADER", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },
	-- Pane keybindings: 'ALT-s'=split 'ALT-v'=vsplit
	{ key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{
		key = "v",
		mods = "LEADER",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Move between panes
	{ key = "LeftArrow", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "DownArrow", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "UpArrow", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "RightArrow", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) },
	-- Full Screen with F11
	{ key = "F11", action = act.ToggleFullScreen },
}
--
-- Command Palette CTRL+SHIFT+P
config.command_palette_font_size = 10
config.command_palette_bg_color = "#394b70"
config.command_palette_fg_color = "#8fce00"
--
-- and finally, return the configuration to wezterm
return config
