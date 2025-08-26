local api = vim.api

-- Alpha sparkle visual
api.nvim_create_autocmd("User", {
  group = api.nvim_create_augroup("AlphaCustom", { clear = true }),
  pattern = "AlphaReady",
  callback = function()
    local bufnr = api.nvim_get_current_buf()
    require("utils.sparkle").start_fading_animation(bufnr, 1)
  end,
})

-- Set filetype to asm for .inc files
api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.inc",
  callback = function()
    vim.bo.filetype = "asm"
  end,
})

-- Disable showtabline and laststatus during prompt
api.nvim_create_autocmd("User", {
  pattern = "TelescopeFindPre",
  callback = function()
    require("utils.telescope").find_pre()
  end,
})

-- Restore state of showtabline and laststatus after prompt
api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function(ev)
    api.nvim_create_autocmd("BufLeave", {
      buffer = ev.buf,
      callback = function()
        require("utils.telescope").leave_prompt()
      end,
      once = true,
    })
  end,
})

-- Highlight /// comments with @ keywords and : keywords
api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  callback = function()
    vim.fn.matchadd("DocKeyword", "/// \\zs@\\w\\+")
    vim.fn.matchadd("TodoKeyword", "/// \\zs\\w\\+:")
    api.nvim_set_hl(0, "DocKeyword", {fg = "#4b495f"})
    api.nvim_set_hl(0, "TodoKeyword", {fg = "#4b495f"})
  end,
  group = api.nvim_create_augroup("CommentHighlight", {clear = true})
})

-- Use formatter for C/C++
api.nvim_create_autocmd("FileType", {
  pattern = {"cpp", "c", "hpp", "h"},
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = "81"

    api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function()
        vim.lsp.buf.format({ timeout_ms = 2000 })
      end,
    })
  end,
})

-- Use gofmt
api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function()
        vim.lsp.buf.format({ timeout_ms = 1000 })
      end,
    })
  end,
})
