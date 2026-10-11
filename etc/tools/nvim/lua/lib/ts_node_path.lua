local function is_normal_mode()
  return vim.api.nvim_get_mode().mode == "n"
end

local function current_win_is_float()
  return vim.api.nvim_win_get_config(0).relative ~= ""
end

local function get_node_path()
  local ok, node = pcall(vim.treesitter.get_node)
  if not ok or not node then
    return nil
  end
  local parts = {}
  while node do
    table.insert(parts, 1, node:type())
    node = node:parent()
  end
  return table.concat(parts, " > ")
end

local function debounce(fn, ms)
  local timer = vim.uv.new_timer()
  return function()
    timer:stop()
    timer:start(ms, 0, vim.schedule_wrap(fn))
  end
end

local M = {}

local state = {
  enabled = true,
  win = nil,
  buf = nil,
  last_path = nil,
  debounce_ms = 75,
}

local function hide()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end
  state.win = nil
end

local function render(path)
  if not path or path == "" then
    hide()
    return
  end

  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
    state.buf = vim.api.nvim_create_buf(false, true)
  end
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, { path })

  local win_width = vim.api.nvim_win_get_width(0)
  local win_height = vim.api.nvim_win_get_height(0)
  local text_width = vim.fn.strdisplaywidth(path)
  local col = math.max(0, win_width - text_width - 1)

  local config = {
    relative = "win",
    win = 0,
    row = win_height - 1,
    col = col,
    width = text_width,
    height = 1,
    style = "minimal",
    focusable = false,
    zindex = 50,
    noautocmd = true,
  }

  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_set_config(state.win, config)
  else
    state.win = vim.api.nvim_open_win(state.buf, false, config)
    vim.api.nvim_set_option_value("winhl", "Normal:TsNodePathOverlay", { win = state.win })
    vim.api.nvim_set_option_value("wrap", false, { win = state.win })
  end
end

function M.refresh(force)
  if not state.enabled or not is_normal_mode() or current_win_is_float() then
    hide()
    return
  end
  local path = get_node_path()
  if not force and path == state.last_path then
    return
  end
  state.last_path = path
  render(path)
end

local debounced_refresh

function M.toggle()
  state.enabled = not state.enabled
  if state.enabled then
    M.refresh(true)
    vim.notify "Tree-sitter path overlay: on"
  else
    hide()
    vim.notify "Tree-sitter path overlay: off"
  end
end

function M.setup(opts)
  opts = opts or {}
  state.debounce_ms = opts.debounce_ms or state.debounce_ms
  state.enabled = opts.enabled ~= false

  vim.api.nvim_set_hl(
    0,
    "TsNodePathOverlay",
    vim.tbl_extend("force", { link = "Comment", default = true }, opts.highlight or {})
  )

  debounced_refresh = debounce(function()
    M.refresh(false)
  end, state.debounce_ms)

  local augroup = vim.api.nvim_create_augroup("TsNodePathOverlay", { clear = true })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = augroup,
    callback = debounced_refresh,
  })

  vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "VimResized", "ColorScheme" }, {
    group = augroup,
    callback = function()
      M.refresh(true)
    end,
  })

  vim.api.nvim_create_autocmd("InsertEnter", {
    group = augroup,
    callback = hide,
  })

  vim.api.nvim_create_autocmd("InsertLeave", {
    group = augroup,
    callback = debounced_refresh,
  })

  vim.api.nvim_create_user_command("TsNodePathToggle", M.toggle, {})
end

return M
