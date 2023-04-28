local FireworksFolder = require(script.Parent.FireworksFolder)
local PhysicsUtility = require(script.Parent.Physics)
local Debris = game:GetService("Debris")

local Fireworks = {}

function Fireworks.getFireworksByName(name)
	local fireworks = {}
	for _, firework in ipairs(FireworksFolder:GetChildren()) do
		if firework.Name == name then
			table.insert(fireworks, firework)
		end
	end
	return fireworks
end

function Fireworks.setPrimaryPartByMass(model)
	-- Sets the primary part of a model to be the one with the highest mass
	local primaryPart = nil
	local highestMass = 0
	for _, object in pairs(model:GetChildren()) do
		if object:IsA("BasePart") then
			local mass = PhysicsUtility.calculateObjectMass(object)
			if mass > highestMass then
				highestMass = mass;
				primaryPart = object;
			end
		end	
	end

	model.PrimaryPart = primaryPart;
	return primaryPart
end

function Fireworks.weldFireworkParts(model)
	local parts = {}
	for _, object in pairs(model:GetDescendants()) do
		if object:IsA("BasePart") then
			table.insert(parts, object)
		end
	end
	if #parts == 0 then
		return
	end
	local rootPart = parts[1]
	for i = 2, #parts do
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = rootPart
		weld.Part1 = parts[i]
		weld.Parent = parts[i]
	end
end

local function scheduleRemoval(object, duration)
	Debris:AddItem(object, duration)
end

local function parentEffect(effect, firework)
	-- Particles and other effects cannot be parents of models, so we parent it to the primary part
	if firework:IsA("Model") then
		local primaryPart = firework.PrimaryPart
		if primaryPart then
			effect.Parent = primaryPart
		end
	else
		effect.Parent = firework
	end
end


function Fireworks.SequenceExecuter(firework, sequence)	
	for index, values in ipairs(sequence) do
		local effectsTable = {}

		local effects = values["Effects"]
		local emitValue = tonumber(values["Emit"])
		local waitValue = tonumber(values["Pause"])
		local lifetimeValue = tonumber(values["EffectLifetime"])
		
		for key, value in pairs(values) do
			if (tostring(key) ~= "Emit") and (tostring(key) ~= "Effects") 
				and (tostring(key) ~= "Pause") and (tostring(key) ~= "EffectLifetime") then
				-- Attempt to set the property
				for _, effect in pairs(effectsTable) do
					local success, err = pcall(function()
						effect[tostring(key)] = value
					end)
					if not success then
						warn("Failed to set property " .. tostring(key) .. " on effect with error: " .. tostring(err))
					end
				end
			end
		end
		
		if effects then
			for _, effect in ipairs(effects) do
				local effect = effect:Clone()
				parentEffect(effect, firework)
				table.insert(effectsTable, effect)

				if effect:IsA("ParticleEmitter") then
					if emitValue then
						effect:Emit(emitValue)
					end
					if lifetimeValue then
						scheduleRemoval(effect, lifetimeValue)
					end
				end
				if effect:IsA("Fire") then
					effect.Enabled = true
					if lifetimeValue then
						scheduleRemoval(effect, lifetimeValue)
					end
				end
				if effect:IsA("PointLight") or effect:IsA("SpotLight") or effect:IsA("SurfaceLight") then
					effect.Enabled = true
					if lifetimeValue then
						scheduleRemoval(effect, lifetimeValue)
					end
				end
				if effect:IsA("Sound") then
					effect:Play()
					if lifetimeValue then
						scheduleRemoval(effect, lifetimeValue)
					end
				end				
			end

		end
		
		if waitValue then
			task.wait(waitValue)
		end
	end
	
end
			
		
	

return Fireworks
