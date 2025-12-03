return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup {
      defaults = {
        prompt_prefix = "",
        selection_caret = " ",
        path_display = { "truncate" },
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "bottom",
            width = { padding = 0.25 },
            height = { padding = 0.15 },
            preview_width = 0.5,
            preview_cutoff = 0, -- uncomment to enable preview
          },
        },
        sorting_strategy = "ascending",
        mappings = {
          ["i"] = {
            ["<C-CR>"] = function()
              local picker = require("telescope.actions.state")
              .get_current_picker(bufnr)
              local entries = picker.finder.results
              local bottom_entry = entries[#entries]
              if bottom_entry then
                local path = bottom_entry.path
                if vim.fn.isdirectory(path) == 1 then
                  local dir = vim.fn.fnamemodify(path, ":p:h:h:")
                  vim.cmd("cd " .. dir)
                else
                  local dir = vim.fn.fnamemodify(path, ":p:h")
                  vim.cmd("cd " .. dir)
                end
              end
              require("telescope.actions").close(bufnr)
            end,
            ["<BS>"] = none,
          },
        },
        preview = false,
      },
      pickers = {
        find_files = { preview = false },
        lsp_document_symbols = { preview = true },
      },
    }
  end,
}
