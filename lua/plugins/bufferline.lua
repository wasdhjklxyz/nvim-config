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
        sort_by = "insert_after_current",
        separator_style = { "", "" },
        modified_icon = "●",
        buffer_close_icon = " ",
        close_icon = " ",
      },
      highlights = {
        fill = {
          fg = "#535353",
          bg = "#000000",
        },
        background = {
          fg = "#535353",
          bg = "#000000",
        },
        buffer_selected = {
          fg = "#c8c8c8",
          --fg = "#3f2c5c",
          bg = "#000000",
          --bg = "#100e1a",
          --bg = "#3f2c5c",
          italic = false,
          bold = true,
        },
        tab = {
          fg = "#535353",
          bg = "#000000",
        },
        tab_selected = {
          fg = "#535353",
          bg = "#000000",
        },
        tab_separator = {
          fg = "#535353",
          bg = "#000000",
        },
        tab_separator_selected = {
          fg = "#535353",
          bg = "#000000",
        },
        tab_close = {
          fg = "#535353",
          bg = "#000000",
        },
        close_button = {
          fg = "#535353",
          bg = "#000000",
        },
        close_button_visible = {
          fg = "#535353",
          bg = "#000000",
        },
        close_button_selected = {
          fg = "#535353",
          bg = "#000000",
        },
        buffer_visible = {
          fg = "#535353",
          bg = "#000000",
        },
        numbers = {
          fg = "#535353",
          bg = "#000000",
        },
        numbers_visible = {
          fg = "#535353",
          bg = "#000000",
        },
        numbers_selected = {
          fg = "#535353",
          bg = "#000000",
          bold = true,
          italic = true,
        },
        diagnostic = {
          fg = "#535353",
          bg = "#000000",
        },
        diagnostic_visible = {
          fg = "#535353",
          bg = "#000000",
        },
        diagnostic_selected = {
          fg = "#535353",
          bg = "#000000",
          bold = true,
          italic = true,
        },
        hint = {
          fg = "#535353",
          bg = "#000000",
        },
        hint_visible = {
          fg = "#535353",
          bg = "#000000",
        },
        hint_selected = {
          fg = "#535353",
          bg = "#000000",
          bold = true,
          italic = true,
        },
        hint_diagnostic = {
          fg = "#535353",
          bg = "#000000",
        },
        hint_diagnostic_visible = {
          fg = "#535353",
          bg = "#000000",
        },
        hint_diagnostic_selected = {
          fg = "#535353",
          bg = "#000000",
          bold = true,
          italic = true,
        },
        info = {
          fg = "#535353",
          bg = "#000000",
        },
        info_visible = {
          fg = "#535353",
          bg = "#000000",
        },
        info_selected = {
          fg = "#535353",
          bg = "#000000",
          bold = true,
          italic = true,
        },
        info_diagnostic = {
          fg = "#535353",
          bg = "#000000",
        },
        info_diagnostic_visible = {
          fg = "#535353",
          bg = "#000000",
        },
        info_diagnostic_selected = {
          fg = "#535353",
          bg = "#000000",
          bold = true,
          italic = true,
        },
        warning = {
          fg = "#535353",
          bg = "#000000",
        },
        warning_visible = {
          fg = "#535353",
          bg = "#000000",
        },
        warning_selected = {
          fg = "#535353",
          bg = "#000000",
          bold = true,
          italic = true,
        },
        warning_diagnostic = {
          fg = "#535353",
          bg = "#000000",
        },
        warning_diagnostic_visible = {
          fg = "#535353",
          bg = "#000000",
        },
        warning_diagnostic_selected = {
          fg = "#535353",
          bg = "#000000",
          bold = true,
          italic = true,
        },
        error = {
          fg = "#535353",
          bg = "#000000",
        },
        error_visible = {
          fg = "#535353",
          bg = "#000000",
        },
        error_selected = {
          fg = "#535353",
          bg = "#000000",
          bold = true,
          italic = true,
        },
        error_diagnostic = {
          fg = "#535353",
          bg = "#000000",
        },
        error_diagnostic_visible = {
          fg = "#535353",
          bg = "#000000",
        },
        error_diagnostic_selected = {
          fg = "#535353",
          bg = "#000000",
          bold = true,
          italic = true,
        },
        modified = {
          fg = "#535353",
          bg = "#000000",
        },
        modified_visible = {
          fg = "#535353",
          bg = "#000000",
        },
        modified_selected = {
          fg = "#535353",
          bg = "#000000",
        },
        duplicate_selected = {
          fg = "#535353",
          bg = "#000000",
          italic = true,
        },
        duplicate_visible = {
          fg = "#535353",
          bg = "#000000",
          italic = true,
        },
        duplicate = {
          fg = "#535353",
          bg = "#000000",
          italic = true,
        },
        separator_selected = {
          fg = "#535353",
          bg = "#000000",
        },
        separator_visible = {
          fg = "#535353",
          bg = "#000000",
        },
        separator = {
          fg = "#535353",
          bg = "#000000",
        },
        indicator_visible = {
          fg = "#535353",
          bg = "#000000",
        },
        indicator_selected = {
          fg = "#535353",
          bg = "#000000",
        },
        pick_selected = {
          fg = "#535353",
          bg = "#000000",
          bold = true,
          italic = true,
        },
        pick_visible = {
          fg = "#535353",
          bg = "#000000",
          bold = true,
          italic = true,
        },
        pick = {
          fg = "#535353",
          bg = "#000000",
          bold = true,
          italic = true,
        },
        offset_separator = {
          fg = "#000000",
          bg = "#000000",
        },
        trunc_marker = {
          fg = "#535353",
          bg = "#000000",
        }

      },
    }
    vim.opt.showtabline = 0  -- Set this to not show by default
  end,
}
