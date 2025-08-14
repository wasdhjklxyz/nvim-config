return {
  "2nthony/vitesse.nvim",
  dependencies = { "tjdevries/colorbuddy.nvim" },
  config = function()
    require("vitesse").setup {
      comment_italics = true,
      transparent_background = true,
      transparent_float_background = true,
    }
  end,
}
