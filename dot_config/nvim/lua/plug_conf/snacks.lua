local Mode = require("config.consts").modes
local Snacks = require("snacks")

Snacks.setup({
	lazygit = {
		configure = true,
	},
	bigfile = { enabled = false },
	dashboard = {
		enabled = true,
		sections = {
			{
				section = "terminal",
				cmd = "cat ~/.config/nvim/chafa-banner.txt",
				height = 17,
				padding = 1,
			},
			{
				pane = 2,
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
	},
	terminal = { enabled = true },
	explorer = { enabled = true },
	indent = { enabled = true },
	input = {
		enabled = true,
	},
	notifier = {
		enabled = true,
		timeout = 3000, -- default timeout in ms
		width = { min = 40, max = 0.4 },
		height = { min = 1, max = 0.6 },
		-- editor margin to keep free. tabline and statusline are taken into account automatically
		margin = { top = 0, right = 1, bottom = 0 },
		padding = true, -- add 1 cell of left/right padding to the notification window
		sort = { "level", "added" }, -- sort by level and time
		-- minimum log level to display. TRACE is the lowest
		-- all notifications are stored in history
		level = vim.log.levels.TRACE,
		icons = {
			error = " ",
			warn = " ",
			info = " ",
			debug = " ",
			trace = " ",
		},
		keep = function(notif)
			return vim.fn.getcmdpos() > 0
		end,
		---@type snacks.notifier.style
		style = "compact",
		top_down = true, -- place notifications from top to bottom
		date_format = "%R", -- time format for notifications
		-- format for footer when more lines are available
		-- `%d` is replaced with the number of lines.
		-- only works for styles with a border
		---@type string|boolean
		more_format = " ↓ %d lines ",
		refresh = 50, -- refresh at most every 50ms
	},
	picker = { enabled = true, prompt = "|> " },
	quickfile = { enabled = false },
	scope = { enabled = false },
	scroll = { enabled = false },
	statuscolumn = { enabled = true },
	words = { enabled = false },
	zen = {
		enabled = true,
		toggles = {
			dim = true,
			git_signs = true,
			mini_diff_signs = true,
			diagnostics = true,
			inlay_hints = true,
		},
		show = {
			statusline = false, -- can only be shown when using the global statusline
			tabline = false,
		},
	},
	styles = {
		notification = {
			-- wo = { wrap = true } -- Wrap notifications
		},
	},
})

vim.keymap.set(Mode.normal, "<leader>ff", function()
	Snacks.picker.files()
end, { noremap = true })

vim.keymap.set(Mode.normal, "<leader>fa", function()
	Snacks.picker.files({
		ignored = true,
	})
end, { noremap = true })

vim.keymap.set(Mode.normal, "<leader>fg", function()
	Snacks.picker.grep()
end, { noremap = true })

vim.keymap.set(Mode.normal, "<leader>fb", function()
	Snacks.picker.buffers()
end, { noremap = true })

vim.keymap.set(Mode.normal, "<leader>fe", function()
	Snacks.explorer()
end, { noremap = true })

vim.keymap.set(Mode.normal, "<leader>fn", function()
	Snacks.picker.notifications()
end, { noremap = true })

vim.keymap.set(Mode.normal, "<leader>fnn", function()
	Snacks.picker.noice()
end, { noremap = true })

vim.keymap.set(Mode.normal, "<leader>z", function()
	Snacks.zen()
end, { noremap = true })

vim.keymap.set(Mode.normal, "<leader>lg", function()
	Snacks.lazygit()
end, { noremap = true })
