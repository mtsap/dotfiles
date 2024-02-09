return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
--
-- return {
--   { "catppuccin/nvim" },
--   name = "catppuccin",
--   priority = 1000,
--   config = function()
--     require("catppuccin").setup()
--
--     -- setup must be called before loading
--     vim.cmd.colorscheme("catppuccin")
--   end,
-- }
-- return {
--   "catppuccin/nvim",
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     priority = 1000,
--
--     config = function()
--       require("catppuccin").setup()
--
--       -- setup must be called before loading
--     end,
--   },
--
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "catppuccin-frappe",
--     },
--   },
-- }
