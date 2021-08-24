local EditorConfig = require 'editorconfig-core/editorconfig'

local M = {}

function M.get_config(path)
  if string.sub(path, 1, 1) == '/' then
    local config = EditorConfig:new(path)
    config:parse()

    return config
  end
end

return M
