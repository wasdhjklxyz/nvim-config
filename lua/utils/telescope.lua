local M = {}

local showtabline
local laststatus

M.find_pre = function()
  M.showtabline = vim.opt.showtabline
  M.laststatus = vim.opt.laststatus
  vim.opt.showtabline = 0
  vim.opt.laststatus = 0
end

M.leave_prompt = function()
  vim.opt.showtabline = M.showtabline
  vim.opt.laststatus = M.laststatus
end

return M
