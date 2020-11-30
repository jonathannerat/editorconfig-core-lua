local parse = require 'core.parser'.parse
local utils = require 'utils'

local M = {}

function M.get_options(filepath)
	local options = {}

	for parent_folder in utils.get_parent_folders(filepath) do
		local editorconfig_path = utils.join_paths(parent_folder, '.editorconfig')
		local _, err = io.open(editorconfig_path)
		if not err then
			local editorconfig = parse(editorconfig_path)
			utils.table_extend(options, editorconfig:get_options(filepath), 'overwrite') 
			if editorconfig.root then
				break
			end
		end
	end

	return options
end

return M
