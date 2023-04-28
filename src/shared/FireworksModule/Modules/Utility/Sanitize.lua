local function sanitize(properties, defaultProperties)
	local sanitizedProperties = {}
	for key, value in pairs(defaultProperties) do
		local userProperty =  properties[key]
		if userProperty ~= nil then
			if type(userProperty) == type(value) then
				sanitizedProperties[key] = userProperty
			else
				sanitizedProperties[key] = value
			end
		else
			sanitizedProperties[key] = value
		end
	end
	return sanitizedProperties
end

return sanitize