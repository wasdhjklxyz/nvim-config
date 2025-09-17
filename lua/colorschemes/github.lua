return {
  "projekt0n/github-nvim-theme",
  config = function()
    require('github-theme').setup({
      palettes = {
        github_light_high_contrast = {
          bg1 = '#000000', -- Black background
          bg0 = '#1d1d2b', -- Alt backgrounds (floats, statusline, ...)
          bg3 = '#121820', -- 55% darkened from stock
          sel0 = '#131b24', -- 55% darkened from stock
        },
      },
      specs = {
        all = {
          inactive = 'bg0', -- Default value for other styles
        },
        github_dark_dimmed = {
          inactive = '#090909', -- Slightly lighter then black background
        },
      },
      groups = {
        all = {
          NormalNC = { fg = 'fg1', bg = 'inactive' }, -- Non-current windows
        },
      },
    })
  end,
}
