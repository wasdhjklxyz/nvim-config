local api = vim.api

-- Alpha sparkle visual
api.nvim_create_autocmd("User", {
  group = api.nvim_create_augroup("AlphaCustom", { clear = true }),
  pattern = "AlphaReady",
  callback = function()
    local bufnr = api.nvim_get_current_buf()
    require("utils.sparkle").setup_highlights()
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

-- Use kernel formatting
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.c", "*.h"},
  callback = function()
    local path = vim.fn.expand('%:p')
    if vim.fn.filereadable('Kbuild') == 1 then
      --vim.fn.filereadable('.clang-format') == 1 then
      vim.opt_local.tabstop = 8
      vim.opt_local.shiftwidth = 8
      vim.opt_local.softtabstop = 8
      vim.opt_local.expandtab = false
      vim.opt_local.textwidth = 80
      vim.opt_local.cindent = true
      vim.opt_local.cinoptions = ":0,l1,t0,g0,(0"
      vim.opt_local.colorcolumn = "80"
    end
  end
})

-- Open PDF
vim.api.nvim_create_autocmd({"BufReadPre"}, {
  pattern = "*.pdf",
  callback = function()
    local file = vim.fn.expand("<afile>:p")
    vim.schedule(function()
      vim.fn.jobstart({"zathura", file}, {detach = true})
      vim.cmd("bwipeout")
    end)
  end
})

vim.api.nvim_create_autocmd({"BufEnter", "ColorScheme"}, {
  pattern = "*.md",
  callback = function()
    vim.defer_fn(function()
      vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = "#e48b9b", bold = true })
      vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = "#6fbce2", bold = true })
      vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = "#a2cca2", bold = true })
      vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = "#e1e388", bold = true })
      vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { fg = "#e786e7", bold = true })
      vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { fg = "#96dbdb", bold = true })
    end, 0)
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    for name, val in pairs(vim.api.nvim_get_hl(0, {})) do
      if val.italic then
        val.italic = false
        vim.api.nvim_set_hl(0, name, val)
      end
    end
    local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment" })
    comment_hl.italic = true
    vim.api.nvim_set_hl(0, "Comment", comment_hl)
    local ts_comment_hl = vim.api.nvim_get_hl(0, { name = "@comment" })
    ts_comment_hl.italic = true
    vim.api.nvim_set_hl(0, "@comment", ts_comment_hl)
    local nt_git_modified_hl = vim.api.nvim_get_hl(0, { name = "NeoTreeGitModified" })
    nt_git_modified_hl.italic = true
    vim.api.nvim_set_hl(0, "NeoTreeGitModified", nt_git_modified_hl)
  end
})
