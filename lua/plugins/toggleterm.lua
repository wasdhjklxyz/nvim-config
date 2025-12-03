return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      autochdir = true,
      start_in_insert = true,
      persist_mode = true,
      direction = "float",
      close_on_exit = true,
      auto_scroll = true,
      float_opts = {
        border = "single", -- "double" "shadow" "curved"
        title_pos = "center", -- "left" "right"
      },
      winbar = { enabled = false, },
    })
  end
}
