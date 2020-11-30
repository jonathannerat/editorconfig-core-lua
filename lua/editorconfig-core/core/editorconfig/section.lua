local globtopattern = require 'utils.globtopattern'.globtopattern
local validate = require 'core.validate'.validate

local Section = {}

function Section:new(glob)
	local o = {
		glob = glob,
		pattern = globtopattern(glob):sub(2, -2), -- remove ^ and $ from both ends
		options = {}
	}
	self.__index = self
	setmetatable(o, self)
	return o
end

function Section:define(key, value)
	local parsed_value = validate(key, value)
	if parsed_value then
		self.options[key] = parsed_value
		return true
	end
end

return Section
