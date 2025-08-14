return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim"
  },
  config = function()
    require("neo-tree").setup {
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      default_component_configs = {
        indent = { indent_size = 2 },
      },
      sources = { "filesystem" },
      window = {
        width = 44,
        mappings = {
          ["<"] = "noop",  -- Used to resize windows (see keymaps)
          [">"] = "noop",  -- Used to resize windows (see keymaps)
          ["/"] = "noop",  -- Disable fuzzy finder
          ["<C-f>"] = "noop",
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_current",
        always_show = { ".gitignore" },
      },
      buffers = {
        follow_current_file = { enabled = false },
      },
      git_status = {
        follow_current_file = { enabled = true },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(arg)
            vim.opt.relativenumber = true
          end,
        },
      },
    }
  end,
}
