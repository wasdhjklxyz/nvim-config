return {
  "NvChad/nvim-colorizer.lua",
  event = "BufReadPre",
  config = function()
    require("colorizer").setup {
      filetypes = {
        "*",
        css = { css = true },
      },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background",
        tailwind = false,
        virtualtext = "■",
      },
    }
  end,
}
