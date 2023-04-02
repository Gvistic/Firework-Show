--[[
	Installation
		Move "RodisFireworksModule" anywhere inside of ReplicatedStorage
		Move "RodisFireworks" anywhere inside of Workspace
		Move "RodisFireworkController" anywhere inside of ServerScriptService

	Introduction
		Welcome to the Rodis Firework Show Developer Event!
		You can use this firework module to create your amazing fireworks shows!

	Getting Started
		To use the Rodis Firework module, follow these steps:

		Create or import a rocket or firework launcher, and place them in Workspace, in the "RodisFireworks" folder.
		Give each type of firework model a unique name (Though you can ignite multiple of the same fireworks if they have the same name).
		Use the firework module to ignite the fireworks!

	Firework Module
		The firework module has three functions:
			1) :Ignite(fireworkType, name, properties)
				This function ignites a rocket given the type, name, and optional properties.
					- fireworkType: The type of firework to ignite. This can be either "Rocket", "Crackle", "Confetti" or "Rainbow"
					- name: The name of the firework(s) you want to ignite.
					- properties (Optional): A table containing any additional properties for the rocket or firework.

			2) :IgniteClassic(fireworkType, name)
			   This function fires the classical fireworks originally created by Stickmasterluke
					- fireworkType: The type of firework to ignite. This can be either "Fan", "Display", "Classic" or "Finale"
					- name: The name of the firework(s) you want to ignite.

			3) :GetRocketFactory()
			   If you're a bit more familiar with object-oriented programming, this function returns the Rocket object,
			   so you have a bit more control features.

	For more documentation and examples on the properties table and rocket object,
	check within this script "[README] Properties" and "[README] Rocket Object".

	Examples:
		1) Igniting a rocket:
			local RodisFireworks = require(game:GetService("ReplicatedStorage").RodisFireworksModule)

			RodisFireworks:Ignite("Rocket", "My Rocket", {
				YForce = 500, -- Velocity
				TimeBeforeExplosion = 10, -- Time before it explodes, basically flight time
			})

		2) Igniting a classic firework:
			local FireworksModule = require(game:GetService("ServerScriptService"):WaitForChild("RodisFireworks"))

			FireworksModule:IgniteClassic("Fan", "Launcher1")
			task.wait(5)
			FireworksModule:IgniteClassic("Display", "Launcher1")
			FireworksModule:IgniteClassic("Classic", "Launcher2")
			task.wait(10)
			FireworksModule:IgniteClassic("Finale", "Launcher1")


		3) Using a Rocket Object:
			local RodisFireworks = require(game:GetService("ReplicatedStorage").RodisFireworksModule)
			local Rocket = RodisFireworks:GetRocketFactory()

			local myRocket = Rocket.new("My Rocket", {
				YForce = 500,
				TimeBeforeExplosion = 10,
			})

			myRocket:Ignite()
			myRocket.Completed:Connect(function()
				print("Rocket exploded")
				myRocket:Respawn()
			end)

	Enjoy!
]]
