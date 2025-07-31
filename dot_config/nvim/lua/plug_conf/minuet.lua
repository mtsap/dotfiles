local mode = require("consts").modes

require("minuet").setup({
	provider = "codestral",
	verbose = true,
	n_completions = 3,
	context_window = 4096,
	provider_options = {
		-- openai_fim_compatible = {
		-- 	api_key = "TERM", -- Please Don't change this, just use TERM should be fine.
		-- 	name = "Ollama",
		-- 	end_point = "http://localhost:11434/v1/completions",
		-- 	model = "llama3.2",
		-- 	optional = {
		-- 		max_tokens = 256,
		-- 		top_p = 0.9,
		-- 	},
		-- },
		-- openai_compatible = {
		-- 	api_key = "TERM", -- Please Don't change this, just use TERM should be fine.
		-- 	name = "Ollama",
		-- 	end_point = "http://localhost:11434/v1/chat/completions",
		-- 	model = "llama3.2",
		-- 	optional = {
		-- 		max_tokens = 512,
		-- 		top_p = 0.9,
		-- 	},
		-- },
		-- openai = {
		-- 	model = "gpt-4.1-mini",
		-- 	stream = true,
		-- 	api_key = "OPENAI_API_KEY",
		-- 	optional = {
		-- 		max_tokens = 256,
		-- 	},
		-- },
		codestral = {
			model = "codestral-latest",
			end_point = "https://api.mistral.ai/v1/fim/completions",
			api_key = "MISTRAL_API_KEY",
			stream = true,
			optional = {
				max_tokens = 512,
				stop = { "[\n\n]" },
				temperature = 0,
			},
		},
	},

	virtualtext = {
		auto_trigger_ft = {},
	},
})

local vt = require("minuet.virtualtext")

vim.keymap.set({ mode.normal, mode.insert }, "<A-n>", function()
	vt.action.prev()
end, { noremap = true, silent = true })

vim.keymap.set({ mode.normal, mode.insert }, "<A-h>", function()
	vt.action.next()
end, { noremap = true, silent = true })

vim.keymap.set({ mode.normal, mode.insert }, "<A-y>", function()
	vt.action.accept()
end, { noremap = true, silent = true })

-- accept whole completion
-- require('minuet.virtualtext').action.accept,
-- -- accept by line
-- require('minuet.virtualtext').action.accept_line,
-- -- accept n lines (prompts for number)
-- require('minuet.virtualtext').action.accept_n_lines,
-- require('minuet.virtualtext').action.next,
-- require('minuet.virtualtext').action.prev,
-- require('minuet.virtualtext').action.dismiss,
-- -- whether the virtual text is visible in current buffer
-- require('minuet.virtualtext').action.is_visible,
