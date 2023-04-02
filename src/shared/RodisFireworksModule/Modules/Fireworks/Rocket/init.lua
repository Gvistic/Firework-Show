local Debris = game:GetService("Debris")

local Rocket = {}
Rocket.__index = Rocket

local Utility = script.Parent.Parent.Utility

local Log = require(Utility.Log)
local Types = require(Utility.Types)
local PhysicsUtility = require(Utility.Physics)
local FireworksUtility = require(Utility.Fireworks)
local SanitizeProperties = require(Utility.Sanitize)
local FireworksFolder = require(Utility.FireworksFolder)

local print, warn = Log.new("[RODIS_FIREWORK_MODULE]: ")

local function copyFireworkTable(input)
	local outputTable = {}
	for _, value in pairs(input) do
		table.insert(outputTable, value:Clone());
	end
	return outputTable
end

local function sanitizeFireworks(properties, defaultProperties, fireworks)
	local sanitizedFireworks = {}
	for _, firework in ipairs(fireworks) do
		local fireworkProperties = properties and SanitizeProperties(properties, defaultProperties) or defaultProperties
		table.insert(sanitizedFireworks, {firework = firework, properties = fireworkProperties})
	end
	return sanitizedFireworks
end

local function anchorToggle(firework, value)
	if firework:IsA("BasePart") then
		firework.Anchored = value
	else
		for _, object in pairs(firework:GetChildren()) do
			if object:IsA("BasePart") then
				object.Anchored = value
			end	
		end
	end
end

local function transparencyToggle(firework, value)
	if firework:IsA("BasePart") then
		firework.Transparency = value
	else
		for _, object in pairs(firework:GetChildren()) do
			if object:IsA("BasePart") then
				object.Transparency = value
			end	
		end
	end
end

local function parentAttachment(firework, attachment)
	if firework:IsA("BasePart") then
		attachment.Parent = firework
	else
		local primaryPart = firework.PrimaryPart
		if primaryPart and primaryPart:IsA("BasePart") then
			attachment.Parent = primaryPart
		else
			warn("Firework model does not have a primary part, please be sure to set it. Attempting to set primary part the part with the largest mass.")
			primaryPart = FireworksUtility.setPrimaryPartByMass(firework)
			if primaryPart then
				attachment.Parent = primaryPart
			end
		end
	end
end

local function createAttachment(firework, fireworkProperties)
	local attachment = Instance.new("Attachment")
	local attachmentPosition = Vector3.new(0, 0, 0)
	if firework:IsA("BasePart") and fireworkProperties.AttachmentCenterOfMass then
		attachmentPosition = firework.CenterOfMass
	end
	if fireworkProperties.AttachmentAlwaysFacesUp then
		--local positionUp = attachmentPosition + Vector3.new(0, 1, 0) -- Get position that is above the attachment
		--attachment.WorldCFrame = CFrame.lookAt(attachmentPosition, positionUp)
		attachment.Position = attachmentPosition
		parentAttachment(firework, attachment)
		attachment.WorldAxis = Vector3.new(1, 0, 0) 
		attachment.WorldSecondaryAxis = Vector3.new(0, 1, 0)
	else
		parentAttachment(firework, attachment)
	end
	return attachment
end


function Rocket.new(fireworkName : string, properties : Types.properties | nil)
	local self = {}
	self.fireworkName = fireworkName
	self.properties = properties
	self.defaultProperties = require(script.Properties)()
	self.fireworks = FireworksUtility.getFireworksByName(fireworkName)
	if #self.fireworks == 0 then
		warn(string.format("Could not find any fireworks given name: %s", fireworkName))
	end
	self.fireworksCopy = copyFireworkTable(self.fireworks)	
	self.ignited = false
	self.event = Instance.new("BindableEvent")
	self.Completed = self.event.Event
	
	self.sanitizedFireworks = sanitizeFireworks(properties, self.defaultProperties, self.fireworks)
	
	setmetatable(self, Rocket)
	return {
		Fireworks = self.sanitizedFireworks,
		Properties = self.sanitizedProperties,
		GetDefaultProperties = self:GetDefaultProperties(),
		SetDefaultProperties = self:SetDefaultProperties(),
		Completed = self.Completed,
		Ignite = self:Ignite(),
		Respawn = self:Respawn()
	}
end

function Rocket:Ignite()
	return function(properties)
		if self.ignited then
			print(string.format("Firework already ignited, be sure to respawn Firework: %s", self.fireworkName))
			return
		end
		self.ignited = true
		for index, fireworkData in ipairs(self.sanitizedFireworks) do
			task.spawn(function()
				local fireworkProperties = fireworkData.properties
				if properties then
					fireworkProperties = SanitizeProperties(properties, fireworkProperties)
				end
				local firework = fireworkData.firework
				firework.Name = string.format("%s (Launched)", firework.Name)
				
				
				if (fireworkProperties.EstimateForce)  then -- and (fireworkProperties.YForce == self.defaultProperties.YForce) 
					local fireworkMass = PhysicsUtility.calculateObjectMass(firework)
					local newYForce = PhysicsUtility.calculateYForce(fireworkMass, fireworkProperties) 
					fireworkProperties.YForce = newYForce
				end
				
				if fireworkProperties.AutomaticlWeld then
					if not firework:IsA("BasePart") then
						FireworksUtility.weldFireworkParts(firework)
					end
				end
				--print("Force:", fireworkProperties.YForce)
				-- Create attachment for force
				local attachment
				if fireworkProperties.UseCustomAttachment then
					attachment = firework:FindFirstChild("FireworkAttachment", true)
					if not attachment then
						warn("Could not find custom attachment (Ensure the name of the attachment is \"FireworkAttachment\", Default attachment used")
						attachment = createAttachment(firework, fireworkProperties)
					end
				else
					attachment = createAttachment(firework, fireworkProperties)
				end
				
				-- Unanchors the launcher then adds a force.
				if not fireworkProperties.Debug then
					anchorToggle(firework, false)
				end
				local force = Instance.new("VectorForce")
				force.Attachment0 = attachment
				if fireworkProperties.AttachmentCenterOfMass then
					force.ApplyAtCenterOfMass = true
				end
				force.Force = Vector3.new(fireworkProperties.XForce, fireworkProperties.YForce, fireworkProperties.ZForce)

				
				if fireworkProperties.Debug then
					force.Enabled = false
					force.Parent = firework
					
					FireworksUtility.SequenceExecuter(firework, fireworkProperties.LaunchSequence)
					
					FireworksUtility.SequenceExecuter(firework, fireworkProperties.ExplosionSequence)

				else
					force.Enabled = true
					force.Parent = firework

					FireworksUtility.SequenceExecuter(firework, fireworkProperties.LaunchSequence)

					-- Wait time before "explosion"
					task.wait(fireworkProperties.TimeBeforeExplosion)
					
					anchorToggle(firework, true)
					transparencyToggle(firework, 1) 
					
					FireworksUtility.SequenceExecuter(firework, fireworkProperties.ExplosionSequence)

				

					Debris:AddItem(firework, fireworkProperties.FireworkLifeTime)

					if index == #self.sanitizedFireworks then
						self.event:Fire()
					end
				end
			end)
		end
	end
end

function Rocket:Respawn()
	return function()
		if self.ignited then
			local newFireworks = {}
			for _, firework in ipairs(self.fireworksCopy) do
				local newFirework = firework:Clone()
				newFirework.Parent = FireworksFolder
				table.insert(newFireworks, newFirework)
			end
			self.sanitizedFireworks = sanitizeFireworks(self.properties, self.defaultProperties, newFireworks)
			self.ignited = false
		end
	end
end

function Rocket:SetDefaultProperties()
	local function updateDefaultProperties(properties)
		self.defaultProperties = properties
		self.sanitizedFireworks = sanitizeFireworks(self.properties, self.defaultProperties, self.fireworks)
	end
	return function(self, properties)
		updateDefaultProperties(properties)
	end
end

function Rocket:GetDefaultProperties()
	return function()
		return self.defaultProperties
	end
end

return Rocket
