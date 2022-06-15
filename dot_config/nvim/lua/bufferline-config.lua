require("bufferline").setup{
  options = {
    numbers = "none",
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    left_trunc_marker = '',
    right_trunc_marker = '',
    color_icons = true, -- whether or not to add the filetype icon highlights
    show_buffer_icons = true , -- disable filetype icons for buffers
    show_buffer_close_icons = false,
    show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = false, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = { 'any', 'any' },
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'insert_after_current' 
  }
}
  -- options = {
  --     -- If lualine is installed tabline will use separators configured in lualine by default.
  --     -- These options can be used to override those settings.
  --       section_separators = {'', ''},
  --       component_separators = {'', ''},
  --       max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
  --       show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
  --       show_devicons = true, -- this shows devicons in buffer section
  --       show_bufnr = false, -- this appends [bufnr] to buffer section,
  --       show_filename_only = false, -- shows base filename only instead of relative path in filename
  --       modified_icon = "+ ", -- change the default modified icon
  --       modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
  --       show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
  --     }
  --   }
