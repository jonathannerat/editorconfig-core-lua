local M = {}

local function validate_enum(accepted_values)
	return function(_, value)
		for _, e in ipairs(accepted_values) do
			if string.lower(value) == e then
				return e
			end
		end
	end
end

local function validate_integer(_, value)
	value = tonumber(value)

	if value and value % 1 == 0 and value > 0 then
		return value
	end
end

local validation_rules = {
	indent_style = {
		validate_enum { 'tab', 'space' }
	},
	indent_size = {
		validate_enum { 'tab' },
		validate_integer
	},
	tab_width = {
		validate_integer
	},
	end_of_line = {
		validate_enum { 'lf', 'cr', 'crlf' }
	},
	charset = {
		validate_enum { 'latin1', 'utf-8', 'utf-8-bom', 'utf-16be', 'utf-16le' }
	},
	trim_trailing_whitespace = {
		validate_enum { 'true', 'false' }
	},
	insert_final_newline = {
		validate_enum { 'true', 'false' }
	},
}

function M.validate(key, value)
	local validators = validation_rules[key] or {}

	for _, validate in pairs(validators) do
		local parsed_value = validate(key, value)
		if parsed_value then
			return parsed_value
		end
	end
end

return M
