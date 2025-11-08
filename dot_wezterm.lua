local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.font_size = 12
config.color_scheme = "AdventureTime"
config.enable_wayland = false
config.enable_tab_bar = false

config.color_scheme = "GruvboxDark"
local gpus = wezterm.gui.enumerate_gpus()

config.window_padding = {
	left = 30,
	right = 20,
	top = 25,
	bottom = 25,
}
config.font = wezterm.font("Maple Mono", { italic = false })
config.font_size = 11.5

config.default_cursor_style = "BlinkingBlock"
config.colors = {

	cursor_bg = "#ff5f15",
}

config.webgpu_preferred_adapter = gpus[1]
config.front_end = "WebGpu"
return config
