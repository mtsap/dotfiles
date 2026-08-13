hl.config({
    input = {
        kb_layout = "us,gr",
        kb_options = "grp:alt_shift_toggle",
        kb_variant = "",
        kb_model = "",
        kb_rules = "",
        follow_mouse = 0,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
        },
    },

    cursor = {
        no_hardware_cursors = 1,
    },

    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 4,
        col = {
            active_border = "rgba(ff8c00ee)",
            inactive_border = "rgba(595959aa)",
        },
        layout = "dwindle",
        allow_tearing = false,
    },

    decoration = {
        rounding = 2,
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
        force_split = 2,
    },

    misc = {
        force_default_wallpaper = 0,
        vrr = 1,
        focus_on_activate = true,
    },

    debug = {
        vfr = true,
    },

    render = {
        new_render_scheduling = true,
    },
})

hl.curve("fluentOut", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })

hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 1, bezier = "fluentOut" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1, bezier = "fluentOut" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1, bezier = "fluentOut" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "fluentOut", style = "fade" })

-- The old dwindle pseudotile master switch no longer exists in 0.55.
-- There is no documented direct replacement in the Lua config API.

-- The old render.cm_fs_passthrough option is not present in 0.55 docs/stubs.
-- This Lua config keeps the rest of the render behavior intact.
