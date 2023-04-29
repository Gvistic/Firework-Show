local Settings = require(script.Parent.Parent.Parent.Settings)

local FireworkFolderName = Settings.FireworkFolderName
local FireworksFolder = game.Workspace:FindFirstChild(FireworkFolderName, true)

if FireworksFolder == nil then
	error(string.format('[FIREWORK_MODULE]: Please ensure there is a folder called "%s" somewhere in workspace.', FireworkFolderName))
end

return FireworksFolder
