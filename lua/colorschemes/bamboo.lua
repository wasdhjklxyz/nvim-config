return {
  "ribru17/bamboo.nvim",
  config = function()
    require("bamboo").setup {
      style = "vulgaris",
      toggle_style_key = nil,
      toggle_style_list = { "vulgaris", "multiplex", "light" },
      transparent = true,
      dim_inactive = false,
      term_colors = true,
      ending_tildes = false,
      cmp_itemkind_reverse = false,
      code_style = {
        comments = { italic = true },
        conditionals = { italic = false },
        keywords = { italic = false },
        functions = { italic = false },
        namespaces = { italic = false },
        parameters = { italic = false },
        strings = { italic = false },
        variables = { italic = false },
      },
      colors = {},
      highlights = {
        ["ColorColumn"] = { bg = "#0e0c1a" },
        ["@comment"] = { fg = "#3a3945" },
        ["LineNr"] = { fg = "#2a2935" },
        ["MatchParen"] = { fg = "#171622", bg = "#e6e6e6" },
      },
      diagnostics = {
        darker = false,
        undercurl = true,
        background = true,
      },
    }
    require("bamboo").load()
  end,
}
