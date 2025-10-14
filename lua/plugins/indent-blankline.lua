return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    require("ibl").setup {
      scope = {
        enabled = false,
      },
      indent = {
        --highlight = { "WhiteSpace" },
        highlight = { "VertSplit" },
        --char = "│", -- 
        --char="▏",
        char="│",
      }
    }
  end,
}
