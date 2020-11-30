local utils = require 'utils'

local EditorConfig = {}

function EditorConfig:new(o)
	o = o or {
		root = false,
		sections = {}
	}
	self.__index = self
	setmetatable(o, self)
	return o
end

function EditorConfig:last_section()
	if #self.sections > 0 then
		return self.sections[#self.sections]
	end
end

function EditorConfig:add_section(section)
	self.sections[#self.sections+1] = section
end

function EditorConfig:get_options(file)
	local options = {}

	for _, section in ipairs(self.sections) do
		if string.match(file, section.pattern) then
			utils.table_extend(options, section.options, 'overwrite')
		end
	end

	return options
end

return EditorConfig
