---@type Wezterm
local wezterm = require("wezterm")

local function use_wayland()
    local curr_desktop = os.getenv("XDG_CURRENT_DESKTOP")
    if curr_desktop == nil or curr_desktop == "Hyprland" or curr_desktop == "KDE" then
        return false
    else
        return true
    end
end

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

    enable_wayland = use_wayland() and true or false,

    leader = { mods = "CTRL", key = "s", timeout_milliseconds = 1000 },
    keys = require("keys"),
}

return config
