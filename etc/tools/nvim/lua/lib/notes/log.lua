local config = {
  template_file = vim.fn.stdpath "config" .. "/templates/daily-log.md",
  root_dir = "/src/repos/me/vivid-notes/log/phased",
}

local format = string.format
local notify = vim.notify
local ll = vim.log.levels

---@param template_path string
---@return string | nil
local function read_template_file(template_path)
  local file = io.open(template_path, "r")
  if not file then
    notify(format("Template file '%s' not found.", template_path), ll.ERROR)
    return nil
  end
  local content = file:read "*a" -- Read the entire file content
  file:close()
  return content
end

M = {}

local vivid_time = require "lib/vivid_time"

---@param vivid_date VividDate
---@return string
function M.create_log_path(vivid_date)
  local log_path = vivid_time.to_log_path(vivid_date)
  return format("%s/%s", config.root_dir, log_path)
end

---@param vivid_date VividDate
---@return string | nil
function M.fill_log_template(vivid_date)
  local slug = vivid_time.to_slug(vivid_date)
  local date_string = vivid_time.to_standard(vivid_date)
  local template_content = read_template_file(config.template_file)
  if template_content == nil then
    return nil
  end
  return (template_content:gsub("{slug}", slug):gsub("{date}", date_string))
end

---@param content string
---@param file_path string
function M.create_log(content, file_path)
  local dir_path = vim.fn.fnamemodify(file_path, ":h")
  vim.fn.mkdir(dir_path, "p")
  vim.cmd(format("edit %s", file_path))
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(content, "\n"))
  vim.cmd "write"
  notify(format("Created log file at '%s'", file_path), ll.INFO)
end

---@param file_path string
function M.open_log(file_path)
  vim.cmd(format("edit %s", file_path))
  notify(format("Opening existng log file at '%s'", file_path), ll.INFO)
end

---@param vivid_date VividDate
function M.log(vivid_date)
  local file_path = M.create_log_path(vivid_date)
  if vim.fn.filereadable(file_path) == 1 then
    M.open_log(file_path)
    return
  end

  local template_content = M.fill_log_template(vivid_date)
  if template_content == nil then
    notify("Cannot open tmeplate", ll.INFO)
  else
    M.create_log(template_content, file_path)
  end
end

function M.log_today()
  local vivid_date = vivid_time.today()
  if vivid_date ~= nil then
    M.log(vivid_date)
  end
end

return M
