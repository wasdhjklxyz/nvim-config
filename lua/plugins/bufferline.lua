return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup {
      options = {
        themeable = true,
        close_command = "Bdelete! %d",
        indicator = { style = "none" },
        offsets = {{
          filetype = "neo-tree",
          highlight = "StatusLineNC",
          separator = true,
        }},
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
      highlights = {
        fill = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        background = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        buffer_selected = {
          fg = "#e0d9c7",
          --fg = "#3f2c5c",
          --bg = "#14131e",
          bg = "#100e1a",
          --bg = "#3f2c5c",
        },
        tab = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        tab_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        tab_separator = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        tab_separator_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        tab_close = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        close_button = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        close_button_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        close_button_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        buffer_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        numbers = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        numbers_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        numbers_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
          bold = true,
          italic = true,
        },
        diagnostic = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        diagnostic_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        diagnostic_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
          bold = true,
          italic = true,
        },
        hint = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        hint_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        hint_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
          bold = true,
          italic = true,
        },
        hint_diagnostic = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        hint_diagnostic_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        hint_diagnostic_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
          bold = true,
          italic = true,
        },
        info = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        info_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        info_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
          bold = true,
          italic = true,
        },
        info_diagnostic = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        info_diagnostic_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        info_diagnostic_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
          bold = true,
          italic = true,
        },
        warning = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        warning_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        warning_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
          bold = true,
          italic = true,
        },
        warning_diagnostic = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        warning_diagnostic_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        warning_diagnostic_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
          bold = true,
          italic = true,
        },
        error = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        error_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        error_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
          bold = true,
          italic = true,
        },
        error_diagnostic = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        error_diagnostic_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        error_diagnostic_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
          bold = true,
          italic = true,
        },
        modified = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        modified_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        modified_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        duplicate_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
          italic = true,
        },
        duplicate_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
          italic = true,
        },
        duplicate = {
          fg = "#e0d9c7",
          bg = "#14131e",
          italic = true,
        },
        separator_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        separator_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        separator = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        indicator_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        indicator_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
        },
        pick_selected = {
          fg = "#e0d9c7",
          bg = "#14131e",
          bold = true,
          italic = true,
        },
        pick_visible = {
          fg = "#e0d9c7",
          bg = "#14131e",
          bold = true,
          italic = true,
        },
        pick = {
          fg = "#e0d9c7",
          bg = "#14131e",
          bold = true,
          italic = true,
        },
        offset_separator = {
          fg = "#2f312c",
          bg = "#14131e",
        },
        trunc_marker = {
          fg = "#3a3d37",
          bg = "#14131e",
        }

      },
    }
    vim.opt.showtabline = 0  -- Set this to not show by default
  end,
}
