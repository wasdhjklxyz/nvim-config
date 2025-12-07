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

-- Diff view
local diffview_open = false
km.set("n", "<leader>dv", function()
  if diffview_open then
    vim.cmd("DiffviewClose")
    diffview_open = false
  else
    vim.cmd("DiffviewOpen")
    diffview_open = true
  end
end)

-- Reverse highlighted lines
km.set('v', '<leader>r', ":!tac<cr>")

-- Search selection
vim.keymap.set('v', '/', [[y/\V<C-R>=escape(@",'/\')<CR><CR>]])

-- Substitute selection
vim.keymap.set('v', '<leader>s', [[y:%s/<C-R>"//gc<Left><Left><Left>]]) -- confirm each
vim.keymap.set('v', '<leader>S', [[y:%s/<C-R>"//g<Left><Left>]]) -- yolo

-- Clear terminal
km.set('t', '<c-l>', '<c-l>')

-- Shebangs
km.set('i', ';bash', '#!/usr/bin/env bash<cr><cr>')
km.set('i', ';sh', '#!/bin/sh<cr><cr>')

-- Unwip (with safety check) - FIXED
km.set('n', '<leader>gu', function()
  local last_msg = vim.fn.system('git log -1 --pretty=%B'):gsub('%s+$', '')
  if last_msg == '--wip--' or last_msg:match('^fixup! %-%-wip%-%-') then
    vim.cmd('silent Git reset HEAD~1')
  else
    vim.notify('Last commit is not WIP: ' .. last_msg, vim.log.levels.WARN)
  end
end, { desc = 'Undo last WIP' })

-- Quick status
km.set('n', '<leader>gs', ':Git<cr>', { silent = true })

-- Show last commit
km.set('n', '<leader>gS', ':G show<cr>', { silent = true })

-- Quick diff
km.set('n', '<leader>gD', ':Gdiffsplit<cr>', { silent = true })

-- Log
km.set('n', '<leader>gl', ':G log --oneline --graph --decorate<cr>', { silent = true })
km.set('n', '<leader>gL', ':G log --oneline --graph --all --decorate<cr>', { silent = true })

-- Telescope branch stuff
km.set('n', '<leader>gb', function()
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local ok, branches = pcall(vim.fn.systemlist, 'git branch --format="%(refname:short)"')
  if not ok or vim.v.shell_error ~= 0 then
    vim.notify('Not in a git repo', vim.log.levels.ERROR)
    return
  end
  table.insert(branches, 1, '+ Create new branch...')
  table.insert(branches, 2, '+ Fetch & show remote branches...')
  pickers.new({}, {
    prompt_title = 'Git Branches',
    finder = finders.new_table({ results = branches }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if not selection or not selection[1] then return end
        local choice = selection[1]
        if choice:match('^%+ Create') then
          vim.ui.input({ prompt = 'Branch name: ' }, function(name)
            if name and name ~= '' then
              vim.cmd('Git checkout -b ' .. vim.fn.fnameescape(name))
              vim.notify('Created: ' .. name, vim.log.levels.INFO)
            end
          end)
        elseif choice:match('^%+ Fetch') then
          vim.cmd('Git fetch --all')
          vim.notify('Fetched. Reopen to see remote branches.', vim.log.levels.INFO)
        else
          vim.cmd('Git checkout ' .. vim.fn.fnameescape(choice))
          vim.notify('→ ' .. choice, vim.log.levels.INFO)
        end
      end)
      map('n', 'dd', function()
        local selection = action_state.get_selected_entry()
        if selection and not selection[1]:match('^%+') then
          local branch = selection[1]
          vim.ui.input({ 
            prompt = 'Delete branch "' .. branch .. '"? (y/N): '
          }, function(confirm)
            if confirm == 'y' then
              vim.cmd('Git branch -d ' .. vim.fn.fnameescape(branch))
              vim.notify('Deleted: ' .. branch, vim.log.levels.WARN)
              actions.close(prompt_bufnr)
            end
          end)
        end
      end)
      return true
    end,
  }):find()
end, { desc = 'Git branch picker' })

-- WIP with auto-branch creation
km.set('n', '<leader>gw', function()
  vim.cmd('wa')
  local last_msg = vim.fn.system('git log -1 --pretty=%B 2>/dev/null'):gsub('%s+$', '')
  -- No WIP exists - prompt for branch
  if last_msg ~= '--wip--' and not last_msg:match('^fixup! %-%-wip%-%-') then
    vim.ui.input({ prompt = 'Branch name (type/scope): ' }, function(name)
      if name and name ~= '' then
        vim.cmd('silent Git checkout -b ' .. vim.fn.fnameescape(name))
        vim.cmd('silent Git add -A')
        vim.cmd('silent Git commit -m "--wip--"')
      end
    end)
    return
  end
  -- Normal WIP
  vim.cmd('silent Git add -A')
  local original_wip_sha = nil
  local handle = io.popen('git log --pretty=%H:%s')
  if handle then
    local commits = {}
    for line in handle:lines() do
      local sha, msg = line:match('^([^:]+):(.+)$')
      if sha and msg then
        table.insert(commits, { sha = sha, msg = msg })
        if not (msg == '--wip--' or msg:match('^fixup!')) then break end
      end
    end
    handle:close()
    for i = #commits, 1, -1 do
      if commits[i].msg == '--wip--' then
        original_wip_sha = commits[i].sha
        break
      end
    end
  end
  if original_wip_sha then
    vim.cmd('silent Git commit --fixup ' .. original_wip_sha)
  else
    vim.cmd('silent Git commit -m "--wip--"')
  end
end, { desc = 'WIP (auto-branch)' })

-- Nuclear finalize (no press-enter spam)
km.set('n', '<leader>gW', function()
  local current_branch = vim.fn.system('git branch --show-current'):gsub('%s+$', '')
  if current_branch == 'main' or current_branch == 'master' then
    vim.api.nvim_echo({{'Already on main', 'WarningMsg'}}, false, {})
    return
  end
  local wip_count = 0
  local handle = io.popen('git log --pretty=%s')
  if handle then
    for line in handle:lines() do
      if line == '--wip--' or line:match('^fixup! %-%-wip%-%-') then
        wip_count = wip_count + 1
      else break end
    end
    handle:close()
  end
  if wip_count == 0 then
    vim.api.nvim_echo({{'No WIPs', 'WarningMsg'}}, false, {})
    return
  end
  local suggested_msg = ''
  if current_branch:match('^([^/]+)/(.+)$') then
    local type, scope = current_branch:match('^([^/]+)/(.+)$')
    suggested_msg = type .. ': ' .. scope:gsub('%-', ' ')
  end
  vim.ui.input({ 
    prompt = 'Commit message: ',
    default = suggested_msg
  }, function(msg)
    if not msg or msg == '' then return end
    local script = string.format([[
    #!/bin/bash
    set -e
    GIT_SEQUENCE_EDITOR="sed -i '2,$ s/^pick/fixup/'" git rebase -i HEAD~%d
    git commit --amend -m %s
    git fetch origin main 2>/dev/null || git fetch origin master 2>/dev/null || true
    git rebase origin/main 2>/dev/null || git rebase origin/master 2>/dev/null || true
    git checkout main
    git merge --ff-only %s
    git branch -d %s
    ]], wip_count, vim.fn.shellescape(msg), vim.fn.shellescape(current_branch), vim.fn.shellescape(current_branch))
    local tmpfile = os.tmpname()
    local f = io.open(tmpfile, 'w')
    f:write(script)
    f:close()
    vim.fn.system('bash ' .. tmpfile .. ' 2>&1')
    os.remove(tmpfile)
    if vim.v.shell_error == 0 then
      vim.cmd('silent checktime')
    else
      vim.api.nvim_echo({{'Failed - check git status', 'ErrorMsg'}}, false, {})
    end
  end)
end, { desc = 'Finalize all' })

-- LaTeX stuff
vim.keymap.set('n', '<leader>lf', ':TexlabBuild<cr>')
vim.keymap.set('n', '<leader>lf', ':TexlabForward<cr>')
