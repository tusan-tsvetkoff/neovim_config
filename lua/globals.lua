---@param v string
---@return string
P = function(v)
  print(vim.inspect(v))
  return v
end

---@param ... string
RELOAD = function(...)
  require('plenary.reload').reload_module(...)
end

---@param name string
---@return table
RD = function(name)
  RELOAD(name)
  return require(name)
end
