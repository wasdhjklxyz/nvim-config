local km = vim.keymap
local tsb = require("telescope.builtin")

-- Save file and quit
km.set("n", "<leader>q", "<cmd>:q!<cr>")

-- Yank to system clipboard
km.set("n", "<s-y>", "\"+y")
km.set("v", "<s-y>", "\"+y")

-- Adjust window size
km.set("n", "<s-right>", "<cmd>vertical resize +2<cr>")
km.set("n", "<s-left>", "<cmd>vertical resize -2<cr>")
km.set("n", "<s-down>", "<cmd>horizontal resize -2<cr>")
km.set("n", "<s-up>", "<cmd>horizontal resize +2<cr>")

-- Navigate windows
km.set("n", "<c-h>", "<c-w>h")
km.set("n", "<c-j>", "<c-w>j")
km.set("n", "<c-k>", "<c-w>k")
km.set("n", "<c-l>", "<c-w>l")
km.set("t", "<c-h>", "<cmd>wincmd h")
km.set("t", "<c-j>", "<cmd>wincmd j")
km.set("t", "<c-k>", "<cmd>wincmd k")
km.set("t", "<c-l>", "<cmd>wincmd l")

-- Toggle file explorer
km.set("n", "\\", "<cmd>Neotree filesystem toggle left<cr>")
km.set("n", "<leader>\\", "<cmd>Neotree filesystem toggle current<cr>")

-- Cycle through bufferline tabs
km.set("n", "<c-n>", "<cmd>BufferLineCycleNext<cr>")
km.set("n", "<c-p>", "<cmd>BufferLineCyclePrev<cr>")

-- Move bufferline tabs
km.set("n", "<c-s-n>", "<cmd>BufferLineMoveNext<cr>")
km.set("n", "<c-s-p>", "<cmd>BufferLineMovePrev<cr>")

-- Close bufferline tab
km.set("n", "<c-c>", "<cmd>bp <bar> bd #<cr>")

-- Toggle bufferline
km.set("n", "<s-b>", function()
  vim.opt.showtabline = vim.opt.showtabline:get() == 0 and 2 or 0
end)

-- Center line
km.set("n", "<leader>c", function()
  local line = vim.api.nvim_get_current_line()
  local len = #line
  local max = vim.g.maxwidth
  if len < max then
    local padding = math.floor((max - len) / 2)
    local centered = string.rep(" ", padding) .. line
    vim.api.nvim_set_current_line(centered)
  end
end)

-- Show git information
km.set("n", "<leader>gs", vim.cmd.Git)
km.set("n", "<leader>gd", "<cmd>Gitsigns preview_hunk_inline<cr>")
km.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>")

-- New window
km.set("n", "<leader>nn", "<cmd>enew<cr>")

-- New vertical window
km.set("n", "<leader>nv", function()
  vim.cmd("vnew")
  tsb.find_files()
end)

-- New horizontal window
km.set("n", "<leader>nh", function()
  vim.cmd("new")
  tsb.find_files()
end)

-- Search for and open file in project
km.set("n", "<leader>pf", tsb.find_files)

-- Search for document symbols
km.set("n", "<leader>pd", function()
  tsb.lsp_document_symbols({
    ignore_symbols = {
      "field",
      "enummember",
    },
    symbol_highlights = {
      Function = "RenderMarkdownH1",
      Enum = "RenderMarkdownH2",
      Class = "RenderMarkdownH3",
      Struct = "RenderMarkdownH4",
    },
  })
end)

-- Search project using live grep
km.set("n", "<leader>ps", tsb.live_grep)

-- Terminal mode to normal mode
km.set("t", "<esc>", "<c-\\><c-n>")

-- Change colorscheme
km.set("n", "<leader>cs", function()
  tsb.colorscheme({ enable_preview = true })
end)

-- Add centering when using { } to navigate
km.set("n", "{", "{zz")
km.set("n", "}", "}zz")

-- Zen mode
km.set("n", "<leader>z", ":ZenMode<cr>")

-- Write quit all
km.set("n", "<leader>x", "<cmd>xa<cr>")

-- Go err
km.set("i", ";ifer", "if err != nil {<cr><cr>}<up><tab><tab>")

-- Copy all
km.set("n", "<leader>y", "magg0vG$<s-y>'a")
