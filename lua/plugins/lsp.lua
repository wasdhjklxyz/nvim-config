return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_lsp.default_capabilities()
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, remap = false }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "L", vim.diagnostic.open_float, opts)
    end
    lspconfig.clangd.setup({
      cmd = { "clangd", "--background-index", "--enable-config" },
      capabilities = capabilities,
      on_attach = on_attach,
    })
    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        ['rust-analyzer'] = {
          checkOnSave = { command = "clippy" },
          cargo = { allFeatures = true },
          procMacro = { enable = true },
        }
      }
    })
    lspconfig.gopls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
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
    })
    lspconfig.ruff.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false
        on_attach(client, bufnr)
      end,
    })
    lspconfig.basedpyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = function(fname)
        return lspconfig.util.root_pattern(
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          ".venv",
          ".git"
        )(fname)
      end,
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = "standard",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticSeverityOverrides = {
              reportMissingTypeStubs = "none",
              reportUnknownMemberType = "none",
              reportUnknownArgumentType = "none",
              reportUnknownVariableType = "none",
            },
          },
        },
      },
    })
    lspconfig.texlab.setup({
      settings = {
        texlab = {
          build = { onSave = true },
          forwardSearch = {
            executable = "zathura",
            args = {
              "--synctex-editor-command",
              [[nvim-texlabconfig -file "%%%{input}" -line %%%{line} -server ]] .. vim.v.servername,
              "--synctex-forward",
              "%l:1:%f",
              "%p",
            },
          },
        },
      },
    })
    local original = vim.lsp.util.make_position_params
    vim.lsp.util.make_position_params = function(window, offset_encoding)
      return original(window, offset_encoding or 'utf-16')
    end
    vim.lsp.set_log_level("off")
  end,
}
