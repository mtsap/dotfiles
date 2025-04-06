vim.o.termguicolors = true
vim.o.background = "dark"

-- Example config in Lua
vim.g.gruvbox_baby_function_style = "NONE"
vim.g.gruvbox_baby_keyword_style = "italic"

-- Each highlight group must follow the structure:
-- ColorGroup = {fg = "foreground color", bg = "background_color", style = "some_style(:h attr-list)"}
-- See also :h highlight-guifg
-- Example:
-- vim.g.gruvbox_baby_highlights = { Normal = { fg = "#123123", bg = "NONE", style = "underline" } }
local colors = require("gruvbox-baby.colors").config()
vim.g.gruvbox_baby_highlights = { Normal = { fg = colors.orange } }
vim.g.gruvbox_baby_keyword_style = "italic"
vim.g.gruvbox_baby_background_color = "soft_flat"

-- Enable telescope theme
-- vim.g.gruvbox_baby_telescope_theme = 1

-- Enable transparent mode
-- vim.g.gruvbox_baby_transparent_mode = 1
vim.cmd.colorscheme("gruvbox-baby")
