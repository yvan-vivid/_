local cache_dir = "base46"

return function()
  local path = require "lib.paths"
  local M = {}

  if vim.g.base46_cache == nil then
    vim.g.base46_cache = path.data(cache_dir) .. "/"
  end

  ---@param name string
  ---@return string
  function M.get_cached(name)
    return vim.g.base46_cache .. name
  end

  ---@param name string
  function M.load_cached(name)
    dofile(M.get_cached(name))
  end

  return M
end
