local globtopattern = require 'globtopattern'.globtopattern
local validate = require 'core.editorconfig.validate'.validate

local Section = {}

function Section:new(glob)
	local o = {
		glob = glob,
		pattern = globtopattern(glob),
		properties = {}
	}
	self.__index = self
	setmetatable(o, self)
	return o
end

function Section:define(key, value)
	local parsed_value = validate(key, value)
	if parsed_value then
		self.properties[key] = parsed_value
		return true
	end
end

return Section
