local supported_values_per_key = {
	indent_style = { 'tab', 'space' },
	indent_size = { 'tab', function(_) return true end },
	end_of_line = { 'lr', 'cr', 'crlf' },
	charset = { 'latin1', 'utf-8', 'utf-8-bom', 'utf-16be', 'utf-16le' },
	trim_trailing_whitespace = { 'true', 'false' },
	insert_final_newline = { 'true', 'false' },
}

local function validate_pairs(key, value)
	local supported_values = supported_values_per_key[key]

	if supported_values then
		for _, supported_value in pairs(supported_values) do
			if type(supported_value) == 'string' and value == supported_value then
				return true
			elseif type(supported_value) == 'function' and supported_value(value) then
				return true
			end
		end
	end

	return false
end

return validate_pairs
