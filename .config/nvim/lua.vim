lua << EOF

require('nvim-tree').setup {
   filters = {
      dotfiles = false,
   },
   disable_netrw = true,
   hijack_netrw = true,
   ignore_ft_on_setup = { "dashboard" },
   auto_close = false,
   open_on_tab = false,
   hijack_cursor = true,
   hijack_unnamed_buffer_when_opening = false,
   update_cwd = true,
   update_focused_file = {
      enable = false,
      update_cwd = false,
   },
   view = {
      allow_resize = true,
      side = "left",
      hide_root_folder = true,
   },
   git = {
      enable = false,
      ignore = false,
   },
}

--require("bufferline").setup{
--options = {
--      offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
--      buffer_close_icon = "",
--      modified_icon = "",
--      close_icon = "",
--      show_close_icon = false,
--      left_trunc_marker = "",
--      right_trunc_marker = "",
--      max_name_length = 14,
--      max_prefix_length = 13,
--      tab_size = 20,
--      show_tab_indicators = true,
--      enforce_regular_tabs = false,
--      view = "multiwindow",
--      show_buffer_close_icons = false,
--      separator_style = "thin",
--      always_show_bufferline = true,
--      diagnostics = false,
--      custom_filter = function(buf_number)
--         -- Func to filter out our managed/persistent split terms
--         local present_type, type = pcall(function()
--            return vim.api.nvim_buf_get_var(buf_number, "term_type")
--         end)
--
--         if present_type then
--            if type == "vert" then
--               return false
--            elseif type == "hori" then
--               return false
--            end
--            return true
--         end
--
--         return true
--      end,
--      offsets = {
--        {
--          filetype = "NvimTree",
--          text = "Files",
--          text_align = "center"
--        },
--        {
--          filetype = "DiffviewFiles",
--          text = "Source Control",
--          text_align = "center"
--        },
--      }
--   },
--
--   -- :h bufferline-highlights
--   -- TODO: Find a way to access the color variables I defined in init.vim
--   highlights = {
--       fill = {
--           guibg = "#111111"
--       },
--       background = {
--           guibg = "#111111"
--       },
--       buffer_selected = {
--           guibg = "#222222"
--       },
--       modified = {
--           guibg = "#222222"
--       },
--       modified_visible = {
--           guibg = "#222222"
--       },
--       modified_selected = {
--           guibg = "#222222"
--       },
--       separator = {
--           guifg = '#111111',
--           guibg = "#111111"
--       },
--       indicator_selected = {
--           guibg = "#222222"
--       },
--  }
--}

require'diffview'.setup {
    diff_binaries = false,
    enhanced_diff_hl = true,
    use_icons = true,
    icons = {
      folder_closed = "",
      folder_open = "",
    },
    signs = {
      fold_closed = "",
      fold_open = "",
    },
    file_panel = {
      position = "left",
      width = 35,
      height = 10,
      listing_style = "tree",       -- One of 'list' or 'tree'
      tree_options = {              -- Only applies when listing_style is 'tree'
        flatten_dirs = true,
        folder_statuses = "only_folded"  -- One of 'never', 'only_folded' or 'always'.
      }
    },
    default_args = {
      DiffviewOpen = {},
      DiffviewFileHistory = {},
    },
}

EOF
