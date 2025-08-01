local M = {}

---@param r string
---@param t string
---@return string
function M.join(r, t)
  return r .. "/" .. t
end

---@param path string
---@return string
function M.data(path)
  return M.join(vim.fn.stdpath "data", path)
end

return M
