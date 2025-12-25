local wezterm = require 'wezterm'

local config = {
    automatically_reload_config = true,
    font = wezterm.font "FiraCode Nerd Font",
    font_size = 10.0,
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },  -- Disable ligatures
    freetype_load_target = "HorizontalLcd",
    color_scheme = 'Github Light (Gogh)',

    colors = {
        foreground = "#24292e",
        background = "#ffffff",
        cursor_bg = "#24292e",
        cursor_border = "#24292e",
        cursor_fg = "#ffffff",
        selection_bg = "#e1e4e8",
        selection_fg = "#24292e",
        ansi = {
            "#24292e", -- black
            "#d73a49", -- red
            "#28a745", -- green
            "#d79b00", -- yellow (adjusted from #ffcc00 to be more readable)
            "#0366d6", -- blue
            "#6f42c1", -- magenta
            "#22863a", -- cyan
            "#586069", -- white
        },
        brights = {
            "#959da5", -- bright black
            "#f97583", -- bright red
            "#34d058", -- bright green
            "#f1af5f", -- bright yellow (adjusted for readability)
            "#2188ff", -- bright blue
            "#8a63d2", -- bright magenta
            "#85e89d", -- bright cyan
            "#6a737d", -- bright white
        },
    },
    enable_tab_bar = false,
    window_decorations = "RESIZE",
    native_macos_fullscreen_mode = true,
    hide_tab_bar_if_only_one_tab = true,
    front_end = "Software",
    audible_bell = "Disabled",
    visual_bell = "Disabled",
    leader = { key="a", mods="CTRL" },
    keys = {
        { key = "-", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
        { key = "|",mods = "LEADER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
        { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
        { key = "h", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
        { key = "j", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Down"}},
        { key = "k", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Up"}},
        { key = "l", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},
        { key = 't', mods = 'CMD', action = wezterm.action{SpawnTab="CurrentPaneDomain"} },
        { key = 'w', mods = 'CMD', action = wezterm.action{CloseCurrentTab={confirm=true}} },
        { key = 'LeftArrow', mods = 'CMD|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
        { key = 'RightArrow', mods = 'CMD|SHIFT', action = wezterm.action.ActivateTabRelative(1) },
        { key = "LeftArrow", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
        { key = "RightArrow", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},

    },
}

return config

