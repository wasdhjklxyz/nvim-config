return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup {
      options = {
        themeable = true,
        close_command = "Bdelete! %d",
        indicator = { style = "none" },
        offsets = {{ filetype = "neo-tree" }},
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        enforce_regular_tabs = true,
        sort_by = "insert_at_end",
        separator_style = { "", "" },
        modified_icon = "●",
        buffer_close_icon = " ",
        close_icon = " ",
      },
    }
    vim.opt.showtabline = 0  -- Set this to not show by default
  end,
}
