--<CR> or o on .. will cd in the above directory
--<C-]> will cd in the directory under the cursor
--<BS> will close current opened directory or parent
--type a to add a file. Adding a directory requires leaving a leading / at the end of the path.
--you can add multiple directories by doing foo/bar/baz/f and it will add foo bar and baz directories and f as a file

--type r to rename a file
--type <C-r> to rename a file and omit the filename on input
--type x to add/remove file/directory to cut clipboard
--type c to add/remove file/directory to copy clipboard
--type y will copy name to system clipboard
--type Y will copy relative path to system clipboard
--type gy will copy absolute path to system clipboard
--type p to paste from clipboard. Cut clipboard has precedence over copy (will prompt for confirmation)
--type d to delete a file (will prompt for confirmation)
--type ]c to go to next git item
--type [c to go to prev git item
--type - to navigate up to the parent directory of the current file/directory
--type s to open a file with default system application or a folder with default file manager (if you want to change the command used to do it see :h nvim-tree.setup under system_open)
--if the file is a directory, <CR> will open the directory otherwise it will open the file in the buffer near the tree
--if the file is a symlink, <CR> will follow the symlink (if the target is a file)
--<C-v> will open the file in a vertical split
--<C-x> will open the file in a horizontal split
--<C-t> will open the file in a new tab
--<Tab> will open the file as a preview (keeps the cursor in the tree)
--I will toggle visibility of hidden folders / files
--H will toggle visibility of dotfiles (files/folders starting with a .)
--R will refresh the tree
--Double left click acts like <CR>
--Double right click acts like <C-]>


require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = true,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    --icons = {
      --hint = "",
      --info = "",
      --warning = "",
      --error = "",
    --}
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}

local map = vim.api.nvim_set_keymap
map('n', '<leader>\t',':NvimTreeToggle<CR>', options)
