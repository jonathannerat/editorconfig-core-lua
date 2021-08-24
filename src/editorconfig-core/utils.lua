local M = {
  log = {},
}

local function fprintf(prefix)
  return function(format, ...)
    io.stderr:write(string.format(prefix .. ': ' .. format .. '\n', ...))
  end
end

M.log.error = fprintf 'ERROR'
M.log.debug = fprintf 'DEBUG'

return M
