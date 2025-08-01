local M = {}

---@param prefix string
---@return string
function M.path_prefix(prefix)
  return prefix .. ":" .. vim.env.PATH
end

---@param paths string[]
function M.add_paths(paths)
  vim.env.PATH = M.path_prefix(table.concat(paths, ":"))
end

---@param path string
function M.add_path(path)
  vim.env.PATH = M.path_prefix(path)
end

return M
