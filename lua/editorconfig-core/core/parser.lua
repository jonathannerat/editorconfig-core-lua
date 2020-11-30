local EditorConfig = require 'core.editorconfig'
local Section = require 'core.editorconfig.section'

local M = {}

local handlers = {
	-- whitespace
	['^%s*$'] = function() end,
	-- comments
	['^%s*[;#]'] = function() end,
	-- key-value pair
	['^%s*(%S+)%s*=%s*(%S+)%s*'] = function(editorconfig, key, value)
		if string.lower(key) == 'root' and string.lower(value) == 'true' then
			if not editorconfig:last_section() then
				editorconfig.root = true
			else
				print(string.format("can't set root option inside a section"))
			end
		else
			local section = editorconfig:last_section()
			if section then
				if not section:define(key, value) then
					print(string.format('invalid key-value pair: %s = %s', key, value))
				end
			else
				print(string.format('invalid option out of section: %s = %s', key, value))
			end
		end
	end,
	-- section
	['^%s*%[(.*)%]%s*$'] = function(editorconfig, glob)
		editorconfig:add_section(Section:new(glob))
	end
}

function M.parse(path)
	local f = io.open(path, "r")
	local editorconfig = EditorConfig:new()

	if f then
		for line in f:lines() do
			for matcher, handler in pairs(handlers) do
				local matches = table.pack(string.match(line, matcher))
				if #matches > 0 then
					handler(editorconfig, table.unpack(matches))
				end
			end
		end
	end

	return editorconfig
end

return M
