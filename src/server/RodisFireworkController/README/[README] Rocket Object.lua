--[[
	Rocket Properties
		Rocket object functions/events:	
			function Rocket.new(name, properties)
				- name: The name of the firework(s) inside the "RodisFireworks" that you wish to associate this rocket object to. 
				- properties: A table containing any additional properties for the rocket or firework. (Explained in later sections)
	
			function Rocket:Ignite()
				Ignites the rocket
							
			function Rocket:Respawn()
				Respawns the rocket
			
			function Rocket:GetDefaultProperties()
				Returns the default properties
			
			function Rocket:SetDefaultProperties(properties)
				Sets the default properties
					- properties: A table containing the firework properties.
			
			function Rocket:SetProperties(properties)
				Sets the properties
					- properties: A table containing the firework properties.
			
			event Rocket.Completed
				Signals once the firework(s) has completed it's flight, and exploded. 
				It signals right as it explodes, it does not wait for the particles to disapear.
]]
