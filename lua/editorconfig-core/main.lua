local lib = require 'lib'
local options = lib.get_options(arg[1])

for key, value in pairs(options) do
	print(string.format('%s = %s', key, value))
end
