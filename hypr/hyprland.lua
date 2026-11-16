-- =========================================================
-- HYPRLAND LUA CONFIGURATION
-- Native Hyprland 0.55+
-- =========================================================

local terminal = "kitty"
local fileManager = "dolphin"
local browser = "brave --password-store=basic"
local mainMod = "SUPER"

-- =========================================================
-- MONITORS
-- =========================================================

hl.monitor({
    output = "DP-1",
    mode = "3840x2160@239.99Hz",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "DP-2",
    mode = "3840x2160@144Hz",
    position = "3840x0",
    scale = 1.25,
    transform = 3,
})

-- =========================================================
-- WORKSPACES
-- =========================================================

-- Monitor 1: DP-1
for i = 1, 5 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "DP-1",
        default = (i == 1),
        persistent = true,
    })
end

-- Monitor 2: DP-2
for i = 6, 10 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "DP-2",
        default = (i == 6),
        persistent = true,
    })
end

-- =========================================================
-- ENVIRONMENT VARIABLES
-- =========================================================

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GDK_DPI_SCALE", "1.5")

-- =========================================================
-- GENERAL SETTINGS
-- =========================================================

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border = {
                colors = {
                    "rgba(33ccffee)",
                    "rgba(00ff99ee)",
                },
                angle = 45,
            },

            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing = false,
    },

    -- =====================================================
    -- DECORATION
    -- =====================================================

    decoration = {
        rounding = 10,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    -- =====================================================
    -- INPUT
    -- =====================================================

    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },

    -- =====================================================
    -- LAYOUTS
    -- =====================================================

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    -- =====================================================
    -- MISC
    -- =====================================================

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
        initial_workspace_tracking = 1,
    },
})

-- =========================================================
-- ANIMATIONS
-- =========================================================

hl.curve("easeOutQuint", {
    type = "bezier",
    points = {
        {0.23, 1},
        {0.32, 1},
    },
})

hl.curve("easeInOutCubic", {
    type = "bezier",
    points = {
        {0.65, 0.05},
        {0.36, 1},
    },
})

hl.curve("linear", {
    type = "bezier",
    points = {
        {0, 0},
        {1, 1},
    },
})

hl.curve("almostLinear", {
    type = "bezier",
    points = {
        {0.5, 0.5},
        {0.75, 1},
    },
})

hl.curve("quick", {
    type = "bezier",
    points = {
        {0.15, 0},
        {0.1, 1},
    },
})

local animations = {
    {"global",        10, "default"},
    {"border",        5.39, "easeOutQuint"},
    {"windows",       4.79, "easeOutQuint"},
    {"windowsIn",     4.1, "easeOutQuint", "popin 87%"},
    {"windowsOut",    1.49, "linear", "popin 87%"},
    {"fadeIn",        1.73, "almostLinear"},
    {"fadeOut",       1.46, "almostLinear"},
    {"fade",          3.03, "quick"},
    {"layers",        3.81, "easeOutQuint"},
    {"layersIn",      4, "easeOutQuint", "fade"},
    {"layersOut",     1.5, "linear", "fade"},
    {"fadeLayersIn",  1.79, "almostLinear"},
    {"fadeLayersOut", 1.39, "almostLinear"},
    {"workspaces",    1.94, "almostLinear", "fade"},
    {"workspacesIn",  1.21, "almostLinear", "fade"},
    {"workspacesOut", 1.94, "almostLinear", "fade"},
    {"zoomFactor",    7, "quick"},
}

for _, anim in ipairs(animations) do
    hl.animation({
        leaf = anim[1],
        enabled = true,
        speed = anim[2],
        bezier = anim[3],
        style = anim[4],
    })
end

-- =========================================================
-- AUTOSTART
-- =========================================================

hl.on("hyprland.start", function()

    hl.exec_cmd("xrandr --output DP-1 --primary")

    hl.exec_cmd("hyprctl dispatch focusmonitor DP-1")

    hl.exec_cmd("awww-daemon")

    hl.exec_cmd("waybar")

    hl.exec_cmd(
        "~/.config/sway/scripts/wallpaper_changer.sh"
    )

    hl.exec_cmd("hypridle")

    hl.exec_cmd(
        "wl-paste --type text --watch cliphist store"
    )

    hl.exec_cmd(
        "wl-paste --type image --watch cliphist store"
    )

    hl.exec_cmd(
        "gsettings set org.gnome.desktop.interface text-scaling-factor 1.5"
    )

end)

-- =========================================================
-- KEYBINDING HELPER
-- =========================================================

local function bind(key, command)
    hl.bind(key, hl.dsp.exec_cmd(command))
end

-- =========================================================
-- APPLICATIONS
-- =========================================================

bind("SUPER + RETURN", terminal)
bind("SUPER + T", "steam")
bind("SUPER + E", fileManager)
bind("SUPER + B", browser)

-- Rofi
bind(
    "SUPER + D",
    "~/.config/rofi/launchers/type-5/launcher.sh || pkill rofi"
)

-- Clipboard
bind(
    "SUPER + V",
    "cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"
)

-- Waybar
bind(
    "SUPER + R",
    "~/.config/waybar/launch.sh"
)

-- =========================================================
-- WINDOW MANAGEMENT
-- =========================================================

hl.bind("SUPER + W", hl.dsp.window.close())

hl.bind("SUPER + M", hl.dsp.exit())

hl.bind("SUPER + P", hl.dsp.window.pseudo())

hl.bind(
    "SUPER + F",
    hl.dsp.window.fullscreen({ mode = "maximized" })
)

hl.bind(
    "SUPER + SHIFT + F",
    hl.dsp.window.fullscreen()
)

-- =========================================================
-- SCREENSHOTS
-- =========================================================

bind("SUPER + PRINT", "hyprshot -m window")

bind("SUPER + S", "hyprshot -m region")

-- Changed from SUPER + D to avoid conflict with Rofi
bind("SUPER + SHIFT + D", "hyprshot -m output")

bind(
    "SUPER + C",
    "hyprshot --clipboard-only -m window"
)

-- =========================================================
-- FOCUS MOVEMENT
-- =========================================================

hl.bind("SUPER + LEFT", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + RIGHT", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + UP", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + DOWN", hl.dsp.focus({ direction = "d" }))

-- =========================================================
-- WINDOW CYCLING
-- =========================================================

hl.bind("SUPER + TAB", hl.dsp.window.cycle_next())

hl.bind(
    "SUPER + SHIFT + TAB",
    hl.dsp.window.cycle_next({ next = false })
)

-- =========================================================
-- WORKSPACE SWITCHING
-- =========================================================

local workspaceKeys = {
    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
    ["9"] = 9,
    ["0"] = 10,
}

for key, workspace in pairs(workspaceKeys) do

    -- Move window to workspace
    hl.bind(
        "SUPER + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = tostring(workspace) })
    )

end

-- =========================================================
-- SYNCHRONIZED WORKSPACE SWITCHING
-- =========================================================

for i = 1, 5 do
    hl.bind("SUPER + SHIFT + " .. i, function()
        hl.dsp.window.move({ workspace = tostring(i) })

        hl.dispatch(hl.dsp.focus({ monitor = "DP-2" }))
        hl.dispatch(hl.dsp.focus({ workspace = i + 5 }))

        hl.dispatch(hl.dsp.focus({ monitor = "DP-1" }))
        hl.dispatch(hl.dsp.focus({ workspace = i }))
    end)

    hl.bind("SUPER + " .. i, function()
        hl.dispatch(hl.dsp.focus({ monitor = "DP-1" }))
        hl.dispatch(hl.dsp.focus({ workspace = i }))

        hl.dispatch(hl.dsp.focus({ monitor = "DP-2" }))
        hl.dispatch(hl.dsp.focus({ workspace = i + 5 }))

        hl.dispatch(hl.dsp.focus({ monitor = "DP-1" }))
        hl.dispatch(hl.dsp.focus({ workspace = i }))
    end)
end


for index = 6, 9 do
    hl.bind("SUPER + SHIFT + " .. index, function()
        hl.dsp.window.move({ workspace = tostring(i) })

        hl.dispatch(hl.dsp.focus({ monitor = "DP-1" }))
        hl.dispatch(hl.dsp.focus({ workspace = index - 5 }))

        hl.dispatch(hl.dsp.focus({ monitor = "DP-2" }))
        hl.dispatch(hl.dsp.focus({ workspace = index }))
    end)
    
    hl.bind("SUPER + " .. index, function()
        hl.dispatch(hl.dsp.focus({ monitor = "DP-2" }))
        hl.dispatch(hl.dsp.focus({ workspace = index }))

        hl.dispatch(hl.dsp.focus({ monitor = "DP-1" }))
        hl.dispatch(hl.dsp.focus({ workspace = index - 5 }))

        hl.dispatch(hl.dsp.focus({ monitor = "DP-2" }))
        hl.dispatch(hl.dsp.focus({ workspace = index }))
    end)
end

-- =========================================================
-- MOVE WINDOWS
-- =========================================================

bind("SUPER + SHIFT + LEFT", "hyprctl dispatch movewindow l")
bind("SUPER + SHIFT + RIGHT", "hyprctl dispatch movewindow r")

-- =========================================================
-- SPECIAL WORKSPACE
-- =========================================================

bind(
    "SUPER + A",
    "hyprctl dispatch togglespecialworkspace magic"
)

bind(
    "SUPER + SHIFT + A",
    "hyprctl dispatch movetoworkspace special:magic"
)

-- =========================================================
-- WORKSPACE SCROLLING
-- =========================================================

bind(
    "SUPER + mouse_down",
    "hyprctl dispatch workspace e+1"
)

bind(
    "SUPER + mouse_up",
    "hyprctl dispatch workspace e-1"
)

-- =========================================================
-- MOUSE WINDOW MOVEMENT / RESIZING
-- =========================================================

hl.bind(
    "SUPER + mouse:272",
    hl.dsp.window.drag()
)

hl.bind(
    "SUPER + mouse:273",
    hl.dsp.window.resize()
)

-- =========================================================
-- AUDIO / BRIGHTNESS
-- =========================================================

local multimedia = {
    {
        "XF86AudioRaiseVolume",
        "pulsemixer --change-volume +2 --max-volume 100"
    },
    {
        "XF86AudioLowerVolume",
        "pactl set-sink-volume @DEFAULT_SINK@ -3%"
    },
    {
        "XF86AudioMute",
        "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    },
    {
        "XF86AudioMicMute",
        "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    },
    {
        "XF86MonBrightnessUp",
        "brightnessctl -e4 -n2 set 5%+"
    },
    {
        "XF86MonBrightnessDown",
        "brightnessctl -e4 -n2 set 5%-"
    },
    {
        "XF86AudioNext",
        "playerctl next"
    },
    {
        "XF86AudioPause",
        "playerctl play-pause"
    },
    {
        "XF86AudioPlay",
        "playerctl play-pause"
    },
    {
        "XF86AudioPrev",
        "playerctl previous"
    },
}

for _, item in ipairs(multimedia) do
    bind(item[1], item[2])
end

-- =========================================================
-- WINDOW RULES
-- =========================================================

hl.window_rule({
    name = "suppress-maximize-events",

    match = {
        class = ".*",
    },

    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",

    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_initial_focus = true,
})
