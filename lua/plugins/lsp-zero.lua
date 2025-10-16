return {
  "VonHeikemen/lsp-zero.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp"
  },
  config = function()
    local lsp = require("lsp-zero")
    local cmp = require("cmp")
    cmp.setup({
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<Up>"] = cmp.mapping.select_prev_item(),
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = {
        {name = "nvim_lsp"},
        {name = "luasnip"},
        {name = "buffer"},
        {name = "path"},
      }
    })
    lsp.on_attach(function(client, bufnr)
      lsp.default_keymaps({buffer = bufnr})
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {
        buffer = bufnr,
        remap = false,
      })
      vim.keymap.set("n", "L", function()
        vim.diagnostic.open_float()
      end, {})
    end)
    require("lspconfig").clangd.setup{
      cmd = { "clangd", "--background-index", "--enable-config" },
      autostart = true,
    }
    require("lspconfig").rust_analyzer.setup{
      settings = {
        ['rust-analyzer'] = {
          checkOnSave = {
            command = "clippy"
          },
          cargo = {
            allFeatures = true,
          },
          procMacro = {
            enable = true
          },
        }
      }
    }
    require("lspconfig").gopls.setup{
      settings = {
        gopls = {
          gofumpt = true,
          usePlaceholders = true,
          completeUnimported = true,
          staticcheck = true,
          analyses = {
            unusedparams = true,
            unreachable = true,
            nilness = true,
          },
          hints = {
            assignVariableTypes = true,
            constantValues = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    }
    lsp.setup()
    vim.lsp.set_log_level("off")
    local original_make_position_params = vim.lsp.util.make_position_params
    vim.lsp.util.make_position_params = function(window, offset_encoding)
      offset_encoding = offset_encoding or 'utf-16'
      return original_make_position_params(window, offset_encoding)
    end
  end,
}
