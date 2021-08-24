local EditorConfig = require 'editorconfig-core/editorconfig'

local M = {}

---Calculates the effective config for the specified file
---@param path string absolute path to the file
---@param configs table with EditorConfig instances up the folder structure
---@return table with properties that match the path
local function get_effective_config(path, configs)
  return configs[1]
end

---Get table with effective configs for the specified file
---@param path string absolute path to the file
---@return table? with effective configs. If none of the rules matched the
--file, returns empty table. If no `.editorconfig` was found, returns nil
function M.get_config(path)
  local configs = {}

  if string.sub(path, 1, 1) == '/' then
    while #path > 0 do
      path = string.gsub(path ,"(.*)/.*", "%1")
      local ec = EditorConfig:new(path .. "/.editorconfig")

      if ec then
        configs[#configs+1] = ec
        if ec.root then break end
      end
    end
  end

  if #configs > 0 then
    return get_effective_config(path, configs)
  end

  return nil
end

return M
