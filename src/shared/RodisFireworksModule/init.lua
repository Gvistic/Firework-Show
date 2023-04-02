--[[

	This is the main firework module, do not edit this unless you know what you're doing

]]

-- // Services
local Debris = game:GetService("Debris")

local FireWorkModule = {}

--// Dependencies
local Modules = script.Modules
local Utility = Modules.Utility
local Fireworks = Modules.Fireworks
local Settings = require(script.Settings)
local Log = require(Utility.Log)
local Types = require(Utility.Types)
local FireworksFolder = require(Utility.FireworksFolder)
local Rocket = require(Fireworks.Rocket)
local Classic = require(Fireworks.Classic)


--// Global Varibles:
local print, warn = Log.new("[RODIS_FIREWORK_MODULE]: ")

local fireworkObjects = {}

function FireWorkModule:IgniteClassic(fireworkType : Types.classicFireworkTypes, name : string)
	if string.lower(fireworkType) == "fan" then
		task.delay(0, function()
			Classic:fireFan(name)
		end)
	end
	if string.lower(fireworkType) == "display" then
		task.delay(0, function()
			Classic:fireDisplay(name)
		end)
	end
	if string.lower(fireworkType)== "classic" then
		task.delay(0, function()
			Classic:fireClassic(name)
		end)
	end
	if string.lower(fireworkType) == "finale" then
		task.delay(0, function()
			Classic:finale(name)
		end)
	end
end

function FireWorkModule:Ignite(fireworkType: Types.fireworkTypes, name: string, properties: Types.properties)
	if string.lower(fireworkType) == "rocket" then
		task.delay(0, function()
			local Rocket = Rocket.new(name, properties)
			Rocket:Ignite()
		end)
	end
	if string.lower(fireworkType) == "crackle" then
		task.delay(0, function()
			local Rocket = Rocket.new(name, properties)
			local crackleProperties = require(Fireworks.FireworkProperties.Crackle)()
			Rocket:SetDefaultProperties(crackleProperties)
			Rocket:Ignite()
		end)
	end
	if string.lower(fireworkType) == "confetti" then
		task.delay(0, function()
			local Rocket = Rocket.new(name, properties)
			local confettiProperties = require(Fireworks.FireworkProperties.Confetti)()
			Rocket:SetDefaultProperties(confettiProperties)
			Rocket:Ignite()
		end)
	end
	if string.lower(fireworkType) == "rainbow" then
		task.delay(0, function()
			local Rocket = Rocket.new(name, properties)
			local rainbowProperties = require(Fireworks.FireworkProperties.RainbowExplosion)()
			Rocket:SetDefaultProperties(rainbowProperties)
			Rocket:Ignite()
		end)
	end
end

function FireWorkModule:GetRocketFactory()
	return Rocket
end


return FireWorkModule
