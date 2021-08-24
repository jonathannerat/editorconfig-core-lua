local M = {
  log = {},
}

local function fprintf(level)
  return function(format, ...)
    if level == "DEBUG" and DEBUG then
      io.stderr:write(string.format(level .. ': ' .. format .. '\n', ...))
    end
  end
end

M.log.error = fprintf 'ERROR'
M.log.debug = fprintf 'DEBUG'

return M
