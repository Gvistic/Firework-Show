local Debris = game:GetService("Debris")

local Utility = script.Parent.Parent.Utility
local FireworksFolder = require(Utility.FireworksFolder)
local Settings = require(script.Parent.Parent.Parent.Settings)

local Classic = {}

--// Global Variables:
local soundsFolder =  script.Sounds
local colors = Settings.Colors


local bang = soundsFolder:WaitForChild("BangSound")
local pop = soundsFolder:WaitForChild("PopSound")
local fountain = soundsFolder:WaitForChild("FountainSound")
local bangsounds = {160248459, 160248479, 160248493}

function makeRandomBang()
	local bangSound = Instance.new("Sound")
	Debris:AddItem(bangSound, 10)
	bangSound.Volume = 1
	bangSound.Pitch = 0.8 + math.random() * 0.4
	bangSound.SoundId = "http://www.roblox.com/asset/?id=" .. bangsounds[math.random(1,3)]
	return bangSound
end

function flare(position, velocity, upwardForce, timer, color)
	local upwardForce = upwardForce or 0
	local timer = timer or 2
	local effectPart = Instance.new("Part")
	effectPart.Name = "EffectFlare"
	effectPart.Transparency = 1
	effectPart.TopSurface = "Smooth"
	effectPart.BottomSurface = "Smooth"
	effectPart.formFactor ="Custom"
	effectPart.Size = Vector3.new(0.4, 0.4, 0.4)
	effectPart.CanCollide = false
	effectPart.CFrame = CFrame.new(position) * CFrame.Angles(math.pi, 0, 0)
	effectPart.Velocity = velocity

	local particles = {}

	local sparkles = Instance.new("Sparkles")
	sparkles.SparkleColor = Color3.new(1, 1, 0)
	sparkles.Parent = effectPart
	table.insert(particles, sparkles)

	local sparkles2 = Instance.new("Sparkles")
	sparkles2.Parent = effectPart
	table.insert(particles, sparkles2)

	local sparkles3 = Instance.new("Sparkles")
	sparkles3.SparkleColor = Color3.new(1, 1, 0)
	sparkles3.Parent = effectPart
	table.insert(particles,sparkles3)

	local sparkles4 = Instance.new("Sparkles")
	sparkles4.Parent = effectPart
	table.insert(particles, sparkles4)

	local fire = Instance.new("Fire")
	fire.Color = Color3.new(1, 1, 0.5)
	fire.SecondaryColor = Color3.new(1, 1, 1)
	fire.Heat = 25
	fire.Parent = effectPart
	table.insert(particles, fire)

	if color ~= nil then
		sparkles.SparkleColor = color
		sparkles3.SparkleColor = color
		fire.Color = color
	end

	if upwardForce > 0 then
		local bodyForce = Instance.new("BodyForce")
		bodyForce.force = Vector3.new(0, effectPart:GetMass() * 196.2 * upwardForce, 0)
		bodyForce.Parent = effectPart
	end
	Debris:AddItem(effectPart, timer + 3)
	effectPart.Parent = game.Workspace
	task.delay(timer, function()
		for _, effect in pairs(particles) do
			if effect and effect.Parent and effect.Enabled then
				effect.Enabled = false
			end
		end
	end)
	return effectPart
end

function Classic:fireClassic(name)
	for _, launcher in pairs(FireworksFolder:GetChildren()) do
		if name ~= nil then
			if launcher.Name ~= name then
				continue
			end
		end
		if launcher.Name ~= "SoundPart" then
			task.spawn(function()
				for i = 1, 3 do
					task.delay(0, function()
						local color = colors[math.random(1, #colors)]
						local bangSound = bang:Clone()
						Debris:AddItem(bangSound, 7)
						bangSound.Parent = launcher

						local flare1 = flare(
							launcher.Position,
							(
								CFrame.Angles(math.pi / 2, 0, 0) * CFrame.Angles((math.random() -0.5) * .5, 
								(math.random() -0.5) * 0.5, 0)
							).LookVector * 100,
							0.8, 
							2
						)
						flare1.RotVelocity = Vector3.new(
							math.random() -0.5,
							math.random() -0.5,
							math.random() -0.5
						) * 100
						local randomBangSound = makeRandomBang()
						randomBangSound.Parent = flare1
						task.wait()
						if bangSound then
							bangSound:Play()
						end
						task.wait(2.5)
						if flare1 and randomBangSound then
							randomBangSound:Play()
							for i = 1, 7 do
								local flare = flare(
									flare1.Position,
									(
										launcher.CFrame
											* CFrame.Angles((i / 7) * math.pi * 2, 0, 0)
									).lookVector * 20,
									0.95,
									3,
									color
								)
								if i == 7 then
									local fizzleSound = Instance.new("Sound")
									fizzleSound.Volume = 1
									fizzleSound.SoundId = "http://www.roblox.com/asset/?id=160247625"
									fizzleSound.Pitch = 0.5
									fizzleSound.Parent = flare
									task.wait()
									if fizzleSound then
										fizzleSound:Play()
									end
								end
							end
						end
					end)
					task.wait(0.4)
				end
			end)
		end
	end
end

local colorCount = 0
function Classic:fireFan(name)
	for _, launcher in pairs(FireworksFolder:GetChildren()) do
		if launcher.Name == "SoundPart" then
			continue
		end
		if name ~= nil then
			if launcher.Name ~= name then
				continue
			end
		end
		task.spawn(function()
			local fountain = fountain:Clone()
			Debris:AddItem(fountain, 10)
			fountain.Parent = launcher
			fountain:Play()
			for i = 1, 7 do
				local pop = pop:Clone()
				Debris:AddItem(pop, 3)
				pop.Parent = launcher
				pop:Play()
				colorCount = (colorCount + 1) % (#colors)
				local flare = flare(
					launcher.Position,
					(
						launcher.CFrame * CFrame.Angles(math.pi / 2, 0, 0) 
							* CFrame.Angles((((i - 1) / 6) -0.5) * 1.5, 0, 0)).lookVector * 30,
					0.95,
					2.0,
					colors[colorCount + 1]
				)

				local sound = Instance.new("Sound")
				sound.Pitch = 0.5 + (math.random() * 0.1)
				sound.SoundId = "http://www.roblox.com/asset/?id=160248604"
				sound.Parent = flare
				task.wait()
				if sound then
					sound:Play()
				end
				task.wait(0.3)
			end
			task.wait(0.3)
			for i = 1, 7 do
				local pop = pop:Clone()
				Debris:AddItem(pop, 3)
				pop.Parent = launcher
				pop:Play()
				colorCount = (colorCount + 1) % (#colors)
				local flare = flare(
					launcher.Position, 
					(
						launcher.CFrame 
							* CFrame.Angles(math.pi / 2, 0, 0) 
							* CFrame.Angles(((1 - ((i - 1) / 6)) -0.5) * 1.5, 0, 0)
					).lookVector * 30,
					0.95,
					2,
					colors[colorCount + 1]
				)
				local sound = Instance.new("Sound")
				sound.Pitch = 0.5 + (math.random() * 0.1)
				sound.SoundId = "http://www.roblox.com/asset/?id=160248604"
				sound.Parent = flare
				task.wait()
				if sound then
					sound:Play()
				end
				task.wait(0.3)
			end
			fountain:Stop()
		end)
	end
end

function Classic:fireDisplay(name)
	for _, launcher in pairs(FireworksFolder:GetChildren()) do
		if launcher.Name == "SoundPart" then
			continue
		end
		if name ~= nil then
			if launcher.Name ~= name then
				continue
			end
		end
		task.spawn(function()
			local bang = bang:Clone()
			Debris:AddItem(bang, 10)
			bang.Parent = launcher
			bang:Play()
			flare(
				launcher.Position,
				(
					launcher.CFrame
						* CFrame.Angles(math.pi / 2, 0, 0)
						* CFrame.Angles(0.8, 0, 0)
				).lookVector * 20, 
				0.95, 
				2
			)
			flare(
				launcher.Position,
				(
					launcher.CFrame
						* CFrame.Angles(math.pi / 2, 0, 0)
						* CFrame.Angles(-0.8, 0, 0)
				).lookVector * 20, 
				0.95, 
				2
			)
			task.wait(0.5)
			bang:Play()
			flare(launcher.Position,
				(
					launcher.CFrame
						* CFrame.Angles(math.pi / 2, 0, 0)
						* CFrame.Angles(0.5, 0, 0)
				).lookVector * 25, 
				0.95, 
				2
			)
			flare(launcher.Position,
				(
					launcher.CFrame
						* CFrame.Angles(math.pi / 2, 0, 0)
						* CFrame.Angles(-0.5, 0, 0)
				).lookVector * 25,
				0.95,
				2
			)
			task.wait(0.5)
			bang:Play()
			flare(launcher.Position,
				(
					launcher.CFrame
						* CFrame.Angles(math.pi / 2, 0, 0)
						* CFrame.Angles(0.25,0,0)
				).lookVector * 32, 0.95, 2
			)
			flare(launcher.Position,
				(
					launcher.CFrame
						*CFrame.Angles(math.pi / 2, 0, 0)
						* CFrame.Angles(-0.25, 0, 0)
				).lookVector * 32,
				0.95,
				2
			)
			task.wait(1)
			bang:Play()
			local flare1 = flare(launcher.Position,
				Vector3.new(0,100,0),
				0.8,
				1
			)
			local bangSound = Instance.new("Sound")
			Debris:AddItem(bangSound, 10)
			bangSound.Volume = 1
			bangSound.SoundId = "http://www.roblox.com/asset/?id=160248522"
			bangSound.Parent = flare1
			task.wait(1)
			if flare1 and bangSound then
				bangSound:Play()
				for i = 1, 5 do
					colorCount = (colorCount + 1) % (#colors)
					flare(flare1.Position,
						(
							launcher.CFrame
								*CFrame.Angles((i / 5) * math.pi * 2, 0, 0)
						).lookVector * 20,
						0.95,
						2,
						colors[colorCount+1]
					)
				end
			end
		end)

	end
end

function Classic:finale(name)
	task.wait(2)
	task.delay(0, function()
		self:fireFan(name)
	end)
	task.wait(4.5)
	task.delay(0, function()
		self:fireDisplay(name)
	end)
	task.wait(4)
	task.delay(0, function()
		self:fireFan(name)
	end)
	task.delay(4.5, function()
		self:fireFan(name)
	end)
	task.delay(9, function()
		self:fireFan(name)
	end)
	task.wait(7)
	task.delay(0, function()
		self:fireClassic(name)
	end)
	task.wait(7)
	task.delay(0, function()
		self:fireClassic(name)
	end)
	task.wait(1)
	task.delay(0, function()
		self:fireClassic(name)
	end)
	task.wait(2)
	task.delay(0, function()
		self:fireClassic(name)
	end)
	task.wait(1)
	task.delay(0, function()
		self:fireDisplay(name)
	end)
	task.wait(9)
end

return Classic

