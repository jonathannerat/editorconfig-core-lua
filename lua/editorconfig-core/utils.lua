local M = {}

--- OS specific path separator
local separator = package.config:sub(1, 1)

--- Join paths using OS folder separator
function M.join_paths(...)
	return table.concat(table.pack(...), separator)
end

--- Iterator over the parent folders of the specified path
function M.get_parent_folders(path)
	if path:sub(1,1) == '~' then path = os.getenv('HOME') .. path:sub(2) end
	if path:sub(1,1) ~= '/' then error 'path must be absolute' end

	local folder = path

	return function()
		if folder and #folder > 0 and not string.match(folder, '^%a:$') then
			folder = string.gsub(folder, '(.*)' .. separator .. '.-$', '%1')
			return folder
		end
	end
end

--- Extend table `a1` with the values found in `a2`, using `type` to resolve conflicts
function M.table_extend(a1, a2, type)
	for key, value in pairs(a2) do
		type = type or 'keep'

		if type == 'keep' then
			if not a1[key] then
				a1[key] = value
			end
		elseif type == 'overwrite' then
			a1[key] = value
		end
	end
end

return M
