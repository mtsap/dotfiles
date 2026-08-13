local programs = require("programs")

local mainMod = "SUPER"
local mainShiftMod = "SUPER + SHIFT"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainShiftMod .. " + N", hl.dsp.exec_cmd(programs.browser))
hl.bind(
	mainShiftMod .. " + Backspace",
	hl.dsp.exec_cmd("swaylock -i ~/Pictures/wallpapers/f14-6.jpg --grace 5 -u --effect-blur 10x5")
)
hl.bind(mainShiftMod .. " + W", hl.dsp.window.close())
hl.bind(mainShiftMod .. " + Q", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(programs.menu))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(programs.rofiWebsearch))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainShiftMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + TAB", hl.dsp.window.cycle_next())
hl.bind(mainShiftMod .. " + TAB", hl.dsp.window.cycle_next({ next = false }))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("ponymix decrease 1"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("ponymix increase 1"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("light -A 5"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("light -U 5"))
hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd("asusctl -n"))
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("asusctl -p"))

hl.bind(
	"switch:on:Lid Switch",
	hl.dsp.exec_cmd("sleep 20 && asusctl anime image -p /home/mtsap/Pictures/f14-11.png -s 1 -a 3.5"),
	{ locked = true }
)

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainShiftMod .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + n", hl.dsp.exec_cmd("voxtype record toggle"))
