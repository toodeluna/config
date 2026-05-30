hl.env("DISPLAY", ":2")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("easeOut", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOut", { type = "bezier", points = { { 0.28, 0.09 }, { 0.59, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "easeOut" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "easeOut" })
hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "easeOut" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "easeOut", style = "slide bottom" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "easeOut", style = "gnomed" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.9, bezier = "easeInOut" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.9, bezier = "easeInOut", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.9, bezier = "easeInOut", style = "slide" })

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(packages.kitty))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(packages.rofi .. " -show drun"))
hl.bind("SUPER + B", hl.dsp.exec_cmd(packages.zen))
hl.bind("SUPER + S", hl.dsp.exec_cmd(packages.hyprshot .. " --mode region --clipboard-only"))
hl.bind("SUPER + C", hl.dsp.exec_cmd(packages.hyprpicker .. " | " .. packages.wl_copy))

hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + Q", hl.dsp.exit())

hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))

hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }))

hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

hl.bind("SUPER + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = "9" }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = "10" }))
hl.bind("ALT + TAB", hl.dsp.focus({ workspace = "previous" }))

hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.config({
	general = {
		layout = "master",

		gaps_in = 5,
		gaps_out = 10,

		border_size = 2,
		resize_on_border = true,

		["col.active_border"] = colors.mauve,
		["col.inactive_border"] = colors.overlay0,
	},

	decoration = {
		rounding = 6,
		rounding_power = 3,

		blur = {
			enabled = true,
			passes = 2,
			size = 5,
			vibrancy = 0.15,
		},

		shadow = {
			enabled = true,
			color = "rgba(" .. colors.crustAlpha .. "aa)",
			range = 6,
			render_power = 3,
		},
	},

	input = {
		kb_layout = xkb.layout,
		kb_options = xkb.options,

		sensitivity = 0,
		follow_mouse = true,

		touchpad = {
			natural_scroll = true,
		},
	},

	misc = {
		disable_hyprland_logo = true,
		force_default_wallpaper = false,
	},

	animations = {
		enabled = true,
	},
})

hl.window_rule({
	name = "suppress-maximize-events",
	suppress_event = "maximize",
	match = { class = ".*" },
})

hl.window_rule({
	name = "fix-xwayland-drags",
	no_focus = true,

	match = {
		class = "^$",
		title = "^$",
		float = true,
		fullscreen = false,
		pin = false,
		xwayland = true,
	},
})

hl.on("hyprland.start", function()
	hl.exec_cmd(packages.xwayland_satellite .. " :2")
	hl.exec_cmd(packages.quickshell)
end)
