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

function EditorConfig:set_root(is_root)
	self.root = is_root
end

function EditorConfig:last_section()
	if #self.sections > 0 then
		return self.sections[#self.sections]
	end
end

function EditorConfig:add_section(section)
	self.sections[#self.sections+1] = section
end

return EditorConfig
