local wezterm = require 'wezterm'

local config = {
    automatically_reload_config = true,
    font = wezterm.font 'Fira Mono',
    font_size = 10.0,
    -- color_scheme = 'Windows 10 Light (base16)',
    color_scheme = 'Londontube (light) (terminal.sexy)',
    --color_scheme = 'Lunaria Light (Gogh)',
    enable_tab_bar = false,
    window_decorations = "RESIZE",
    native_macos_fullscreen_mode = true,
    hide_tab_bar_if_only_one_tab = true,
    front_end = "Software",
    audible_bell = "Disabled"
    visual_bell = {
        fade_in_duration_ms = 75,
        fade_out_duration_ms = 75,
        target = 'CursorColor',
    },
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
    },
}

return config

