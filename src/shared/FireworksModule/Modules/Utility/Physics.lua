local Physics = {}


function Physics.calculateObjectMass(object)
	local mass = 0
	if object:IsA("BasePart") then
		mass = object.Mass
	end
	local parts = object:GetDescendants()
	for _, part in ipairs(parts) do
		if part:IsA("BasePart") and part:GetMass() then
			mass = mass + part:GetMass()
		end
	end
	return mass
end

function Physics.calculateYForce(mass, properties)
	local desiredForce = properties.YForce
	local desiredMass = properties.Mass

	local gravity = game.Workspace.Gravity
	local minimumForce = mass * gravity

	local forcePerMass = desiredForce / desiredMass
	local force = (forcePerMass * mass + minimumForce)
	return force
end

function Physics.setMass(object, properties)
	if object:IsA("BasePart") then
		local mass = properties.Mass
		local part = object
		part.CustomPhysicalProperties = PhysicalProperties.new(
			properties.Density, properties.Friction, 
			properties.Elasticity, properties.FrictionWeight, properties.ElasticityWeight
		)

		local volume = part.Mass / part.CustomPhysicalProperties.Density
		local targetDensity = volume * (mass)
		local massModifier =  mass / (volume * targetDensity) 
		local Density = volume * (mass * massModifier)
		local physicalProperties = PhysicalProperties.new(Density, properties.Friction, properties.Elasticity,
			properties.FrictionWeight, properties.ElasticityWeight)
		part.CustomPhysicalProperties = physicalProperties
		--print(part, "Has a Mass of: ".. part.Mass)
	else
		local parts = object:GetDescendants()
		for _, part in ipairs(parts) do
			if part:IsA("BasePart") then
				if part:IsA("UnionOperation") then
					part.Massless = true
				end
				local mass = properties.Mass
				part.CustomPhysicalProperties = PhysicalProperties.new(
					properties.Density, properties.Friction, 
					properties.Elasticity, properties.FrictionWeight, properties.ElasticityWeight
				)

				local volume = part.Mass / part.CustomPhysicalProperties.Density
				local targetDensity = volume * (mass)
				local massModifier =  mass / (volume * targetDensity) 
				local Density = volume * (mass * massModifier)
				local physicalProperties = PhysicalProperties.new(Density, properties.Friction, properties.Elasticity,
					properties.FrictionWeight, properties.ElasticityWeight)
				part.CustomPhysicalProperties = physicalProperties
				--print(part, "Has a Mass of: ".. part.Mass)
			end
		end
	end
end


return Physics
