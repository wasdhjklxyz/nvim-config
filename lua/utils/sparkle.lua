local M = {}

M.config = {
  animation = {
    initial_interval = 90,
    min_interval = 70,
    max_interval = 100,
    step_size = 5,
    variation = {
      min = 3,
      max = 6
    }
  },
  colors = {
    "#2e2e2e", "#3e3e3e", "#4e4e4e", "#5e5e5e", "#6e6e6e",
    "#7e7e7e", "#8e8e8e", "#9e9e9e", "#aeaeae", "#bebece"
  },
  display = {
    max_rows = 42,
    step_speed = 1
  }
}

M.namespace_id = vim.api.nvim_create_namespace("HighlightNamespace")
M.animation_timer = nil
M.curr_colors = {}

M.setup = function(user_config)
  if user_config then
    if user_config.animation then
      for k, v in pairs(user_config.animation) do
        M.config.animation[k] = v
      end
      if user_config.animation.variation then
        for k, v in pairs(user_config.animation.variation) do
          M.config.animation.variation[k] = v
        end
      end
    end
    if user_config.colors then
      M.config.colors = user_config.colors
    end
    if user_config.display then
      for k, v in pairs(user_config.display) do
        M.config.display[k] = v
      end
    end
  end
  M.setup_highlights()
  return M
end

M.setup_highlights = function()
  for i, color in ipairs(M.config.colors) do
    vim.cmd("highlight CustomColor" .. i .. " guifg=" .. color)
  end
end

M.clear_highlights = function(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return false
  end
  vim.api.nvim_buf_clear_namespace(bufnr, M.namespace_id, 0, -1)
  return true
end

M.fade_color = function(color_index, step)
  step = step or M.config.display.step_speed
  local new_index = color_index + step
  if new_index > #M.config.colors then
    new_index = 1
  elseif new_index < 1 then
    new_index = #M.config.colors
  end
  return new_index
end

M.apply_fading_highlights = function(bufnr, start_row, end_row, step)
  step = step or M.config.display.step_speed
  end_row = math.min(end_row, M.config.display.max_rows)
  for i = start_row, end_row do
    local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1]
    if line then
      for j = 1, #line do
        local char = line:sub(j, j)
        if char ~= " " then
          local color_index = M.curr_colors[i] and
          M.curr_colors[i][j] or
          math.random(1, #M.config.colors)
          color_index = M.fade_color(color_index, step)
          M.curr_colors[i] = M.curr_colors[i] or {}
          M.curr_colors[i][j] = color_index
          vim.api.nvim_buf_set_extmark(bufnr, M.namespace_id, i, j - 1, {
            end_row = i,
            end_col = j,
            hl_group = "CustomColor" .. color_index,
          })
        end
      end
    end
  end
end

M.start_fading_animation = function(bufnr, step)
  step = step or M.config.display.step_speed
  if not vim.api.nvim_buf_is_valid(bufnr) then 
    if M.animation_timer then
      M.animation_timer:stop()
      M.animation_timer = nil
    end
    return nil
  end
  if M.animation_timer then
    M.animation_timer:stop()
    M.animation_timer = nil
  end
  local cfg = M.config.animation
  local offset = cfg.step_size
  local interval = cfg.initial_interval
  M.animation_timer = vim.loop.new_timer()
  M.animation_timer:start(0, interval, vim.schedule_wrap(function()
    if not M.clear_highlights(bufnr) then return end
    M.apply_fading_highlights(bufnr, 0, M.config.display.max_rows, step)
    interval = interval + offset
    if interval >= cfg.max_interval then
      offset = -math.random(cfg.variation.min, cfg.variation.max)
    elseif interval <= cfg.min_interval then
      offset = math.random(cfg.variation.min, cfg.variation.max)
    end
    M.animation_timer:set_repeat(interval)
    M.animation_timer:again()
  end))
end

M.stop_animation = function()
  if M.animation_timer then
    M.animation_timer:stop()
    M.animation_timer = nil
  end
end

return M
