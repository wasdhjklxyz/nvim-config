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

-- Wip commit keybinding
km.set('n', '<leader>gw', function()
  -- Check if HEAD is a WIP
  local last_msg = vim.fn.system('git log -1 --pretty=%B'):gsub('%s+$', '')
  vim.cmd('Git add -A')
  if last_msg == '--wip--' then
    -- Already have a WIP, fixup to it
    vim.cmd('Git commit --fixup HEAD')
  else
    -- First WIP, create normally
    vim.cmd('Git commit -m "--wip--"')
  end
  vim.notify('WIP committed', vim.log.levels.INFO)
end, { desc = 'WIP commit (auto-fixup chain)' })

-- Unwip (with safety check)
km.set('n', '<leader>gu', function()
  local last_msg = vim.fn.system('git log -1 --pretty=%B'):gsub('%s+$', '')
  if last_msg == '--wip--' then
    vim.cmd('Git reset --soft HEAD~1')
    vim.notify('WIP undone', vim.log.levels.INFO)
  else
    vim.notify('Last commit is not WIP: ' .. last_msg, vim.log.levels.WARN)
  end
end)

-- Quick status
km.set('n', '<leader>gs', ':Git<cr>')

-- Show last commit
km.set('n', '<leader>g<s-s>', ':G show<cr>')

-- Quick diff
km.set('n', '<leader>g<s-d>', ':Gdiffsplit<cr>')

-- Log
km.set('n', '<leader>gl', ':G log --oneline --graph --decorate<cr>')
km.set('n', '<leader>g<s-l>', ':G log --oneline --graph --all --decorate<cr>')

-- Telescope branch stuff
km.set('n', '<leader>gb', function()
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  -- Get branches (handle errors)
  local ok, branches = pcall(vim.fn.systemlist, 'git branch --format="%(refname:short)"')
  if not ok or vim.v.shell_error ~= 0 then
    vim.notify('Not in a git repo', vim.log.levels.ERROR)
    return
  end
  -- Add create option + remote branches option
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
          -- Escape branch names (could have special chars)
          vim.cmd('Git checkout ' .. vim.fn.fnameescape(choice))
          vim.notify('→ ' .. choice, vim.log.levels.INFO)
        end
      end)
      -- Add delete branch mapping
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
end)

-- Smart WIP auto-squashing rebase
km.set('n', '<leader>gR', function()
  -- Count consecutive WIP commits from HEAD
  local wip_count = 0
  local handle = io.popen('git log --pretty=%s')
  if handle then
    for line in handle:lines() do
      if line == '--wip--' then
        wip_count = wip_count + 1
      else
        break  -- Stop at first non-WIP
      end
    end
    handle:close()
  end
  if wip_count == 0 then
    -- No WIPs, ask for manual count
    local count = vim.fn.input('Rebase how many commits? ', '5')
    if count ~= '' then
      vim.cmd('Git rebase -i HEAD~' .. count)
    end
  else
    -- Found WIPs, ask if they want to auto-squash
    local total = wip_count + 1  -- Include the commit before WIPs
    vim.ui.select(
      {
        'Auto-squash ' .. wip_count .. ' WIP commits',
        'Interactive rebase last ' .. total .. ' commits',
        'Custom count',
      },
      { prompt = 'Found ' .. wip_count .. ' WIP commits:' },
      function(choice)
        if choice == nil then return end
        if choice:match('^Auto%-squash') then
          -- Set all WIPs to fixup, keep base commit as pick
          vim.cmd('Git rebase -i HEAD~' .. total)
          -- Auto-edit the rebase todo file
          vim.defer_fn(function()
            -- Change all '--wip--' lines to fixup
            vim.cmd([[%s/^pick \(.\{-}\) --wip--$/fixup \1 --wip--/e]])
            vim.cmd('write')
            vim.notify('WIPs marked as fixup. Review and :wq', vim.log.levels.INFO)
          end, 100)
        elseif choice:match('^Interactive') then
          vim.cmd('Git rebase -i HEAD~' .. total)
        else  -- Custom
          local count = vim.fn.input('Rebase commits: ', tostring(total))
          if count ~= '' then
            vim.cmd('Git rebase -i HEAD~' .. count)
          end
        end
      end
    )
  end
end, { desc = 'Smart rebase (auto-detect WIPs)' })

-- Fixup current file to last commit
km.set('n', '<leader>gf', function()
  vim.cmd('Git add %')
  vim.cmd('Git commit --fixup HEAD')
  vim.notify('Fixup commit created', vim.log.levels.INFO)
end, { desc = 'Fixup current file to HEAD' })

-- Fixup to specific commit (with picker)
km.set('n', '<leader>gF', function()
  -- Get recent commits
  local commits = vim.fn.systemlist(
    'git log --oneline --no-decorate -20'
  )
  vim.ui.select(commits, {
    prompt = 'Fixup to which commit?',
  }, function(choice)
    if choice then
      local sha = choice:match('^(%w+)')
      vim.cmd('Git add %')
      vim.cmd('Git commit --fixup ' .. sha)
      vim.notify('Fixup → ' .. sha, vim.log.levels.INFO)
    end
  end)
end, { desc = 'Fixup to specific commit' })

-- Create branch + make first WIP (combined operation)
km.set('n', '<leader>gn', function()
  vim.ui.input({ prompt = 'Branch name (type/scope): ' }, function(name)
    if name and name ~= '' then
      vim.cmd('Git checkout -b ' .. vim.fn.fnameescape(name))
      vim.cmd('Git add -A')
      vim.cmd('Git commit -m "--wip--"')
      vim.notify('Branch created: ' .. name, vim.log.levels.INFO)
    end
  end)
end, { desc = 'New branch + initial WIP' })

-- Finish WIP chain: squash all WIPs and reword
km.set('n', '<leader>gW', function()
  -- Count WIPs
  local wip_count = 0
  local handle = io.popen('git log --pretty=%s')
  if handle then
    for line in handle:lines() do
      if line == '--wip--' or line:match('^fixup! %-%-wip%-%-') then
        wip_count = wip_count + 1
      else
        break
      end
    end
    handle:close()
  end
  if wip_count == 0 then
    vim.notify('No WIP commits to finalize', vim.log.levels.WARN)
    return
  end
  -- Get branch name for conventional commit suggestion
  local branch = vim.fn.system('git branch --show-current'):gsub('%s+$', '')
  local suggested_msg = ''
  -- Parse branch name (e.g., "feat/user-auth" → "feat: user auth")
  if branch:match('^([^/]+)/(.+)$') then
    local type, scope = branch:match('^([^/]+)/(.+)$')
    suggested_msg = type .. ': ' .. scope:gsub('%-', ' ')
  end
  vim.ui.input({ 
    prompt = 'Commit message (conventional format): ',
    default = suggested_msg
  }, function(msg)
    if msg and msg ~= '' then
      -- Squash all WIPs
      vim.cmd('Git rebase -i HEAD~' .. (wip_count + 1))
      -- Auto-edit: mark WIPs as fixup, reword base commit
      vim.defer_fn(function()
        -- Mark all WIP/fixup lines as fixup
        vim.cmd([[%s/^pick \(.\{-}\) \(--wip--\|fixup! --wip--\)$/fixup \1 \2/e]])
          -- Change first pick to reword
          vim.cmd([[1s/^pick /reword /]])
          vim.cmd('write')
          -- Set the commit message for reword
          vim.defer_fn(function()
            -- This runs when the commit message editor opens
            vim.cmd([[%d]])  -- Delete all
            vim.api.nvim_buf_set_lines(0, 0, 0, false, { msg })
            vim.cmd('write | quit')
          end, 200)
          vim.notify('Squashing WIPs into: ' .. msg, vim.log.levels.INFO)
        end, 100)
      end
    end)
  end, { desc = 'Finalize WIP chain (squash + conventional commit)' })

  -- Merge current branch to main (after finalization)
  km.set('n', '<leader>gM', function()
    local current = vim.fn.system('git branch --show-current'):gsub('%s+$', '')
    if current == 'main' or current == 'master' then
      vim.notify('Already on main branch', vim.log.levels.WARN)
      return
    end
    vim.ui.select(
      { 'Merge to main (fast-forward)', 'Merge to main (no-ff)', 'Cancel' },
      { prompt = 'Merge ' .. current .. ' → main?' },
      function(choice)
        if not choice or choice == 'Cancel' then return end
        local ff_flag = choice:match('fast%-forward') and '' or '--no-ff'
        vim.cmd('Git checkout main')
        vim.cmd('Git merge ' .. ff_flag .. ' ' .. vim.fn.fnameescape(current))
        vim.ui.select(
          { 'Keep branch', 'Delete branch' },
          { prompt = 'Branch ' .. current .. ' merged. Keep or delete?' },
          function(action)
            if action == 'Delete branch' then
              vim.cmd('Git branch -d ' .. vim.fn.fnameescape(current))
              vim.notify('Merged and deleted: ' .. current, vim.log.levels.INFO)
            else
              vim.notify('Merged: ' .. current, vim.log.levels.INFO)
            end
          end
        )
      end
    )
  end, { desc = 'Merge current branch to main' })
