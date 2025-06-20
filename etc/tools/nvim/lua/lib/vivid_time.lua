---@class VividDateSpan
---@field _type "span"
---@field period number
---@field spoke number
---@field arc number
---@field phase number

---@class VividDateInterstice
---@field _type "interstice"
---@field phase number

---@class VividDate
---@field year number
---@field parts VividDateSpan | VividDateInterstice

---@class VividDateFormat
---@field full string
---@field span string
---@field interstice string

local standard_format = {
  full = "∆ %d: %s",
  span = "%d ∘ %d ∘ %d ∘ %d",
  interstice = "interstice ∘ %d",
}

local slug_format = {
  full = "%d--%s",
  span = "%d-%d-%d-%d",
  interstice = "interstice-%d",
}

local log_path_format = {
  full = "%d/%s",
  span = "%d/%d/%d/%d.md",
  interstice = "interstice/%d.md",
}

local format = string.format

---@param date_str string
---@return VividDate | nil
local function date_parse(date_str)
  local template = "∆ (%d+): (%d) ∘ (%d) ∘ (%d) ∘ (%d)"
  local year, period, spoke, arc, phase = string.match(date_str, template)
  if year ~= nil then
    return {
      year = tonumber(year),
      parts = {
        _type = "span",
        period = tonumber(period),
        spoke = tonumber(spoke),
        arc = tonumber(arc),
        phase = tonumber(phase),
      },
    }
  end

  template = "∆ (%d+): Interstice ∘ (%d)"
  year, phase = string.match(date_str, template)
  if year ~= nil then
    return {
      year = tonumber(year),
      parts = {
        _type = "interstice",
        phase = tonumber(phase),
      },
    }
  end
end

local M = {}

---@param template VividDateFormat
---@param vivid_date VividDate
---@return string
function M.format(template, vivid_date)
  local parts
  if vivid_date.parts._type == "span" then
    local span = vivid_date.parts
    parts = format(template.span, span.period, span.spoke, span.arc, span.phase)
  else
    local interstice = vivid_date.parts
    parts = format(template.interstice, interstice.phase)
  end

  return format(template.full, vivid_date.year, parts)
end

---@return string
function M.today_as_standard()
  local v = vim.fn.system("~/_/bin/vivid-time today"):gsub("\n$", "")
  return v
end

---@return VividDate | nil
function M.today()
  return date_parse(M.today_as_standard())
end

---@param vivid_date VividDate
---@return string
function M.to_standard(vivid_date)
  return M.format(standard_format, vivid_date)
end

---@param vivid_date VividDate
---@return string
function M.to_slug(vivid_date)
  return M.format(slug_format, vivid_date)
end

---@param vivid_date VividDate
---@return string
function M.to_log_path(vivid_date)
  return M.format(log_path_format, vivid_date)
end

return M
