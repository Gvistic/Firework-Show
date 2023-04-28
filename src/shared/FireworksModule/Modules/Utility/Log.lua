local Log = {}
Log.__index = Log

function Log.new(prefix : string | nil, suffix: string | nil)
	local self = {}
	self.prefix = prefix or ""
	self.suffix = suffix or ""

	setmetatable(self, Log)
	return self:Print(), self:Warn()
end

function Log:Print()
	return function(...)
		print(self.prefix, ..., self.suffix)
	end
end

function Log:Warn()
	return function(...)
		warn(self.prefix, ..., self.suffix)
	end
end

return Log
