# RodisFireworks
 
 Show off your amazing fireworks shows easily with this plugin! 


 ## Installation
 1. Grab a copy from: [TBA]
 2. Insert the model through Roblox Studio. 
 3. Open the "RodisFireworks" folder. 
 4. Move and ungroup everything respectively.
  - "RodisFireworksModule" -> ReplciatedStorage
  - "RodisFireworkController" -> ServerScriptService
  - "RodisFireworks" -> Workspace


## Example (Non-Object):

```lua
-- Reference to firework module.
local RodisFireworksModule = require(game:GetService("ReplicatedStorage").RodisFireworksModule)

task.wait(2)

-- Ignite Firework1 with type of "Rocket", you can choose from: "Rocket", "Crackle", "Confetti" and "Rainbow"
RodisFireworksModule:Ignite("Rocket","Firework1")
```


## Examples (Object):

1. Ignite firework and respawn it.
```lua
-- Reference to firework module.
local RodisFireworksModule = require(game:GetService("ReplicatedStorage").RodisFireworksModule)

-- Creates a new rocket factory named "MyRocket"
local myRocket = RodisFireworksModule:GetRocketFactory();

-- Creates a new Rocket object with the given name and properties
local rocket1 = myRocket.new("Firework1", {
	YForce = 300; -- How fast the force is on the Y axis.
	TimeBeforeExplosion = 2.5; -- How long in seconds it should fly before exploding.
})

-- Ignite the rocket
rocket1:Ignite()

-- Wait for the rocket to complete its sequence of effects
rocket1.Completed:Wait()

-- Respawn the rocket
rocket1:Respawn()
```
2. Infinetly ignite and respawn firework.
```lua
-- Reference to firework module.
local RodisFireworksModule = require(game:GetService("ReplicatedStorage").RodisFireworksModule)

-- Creates a new rocket factory named "MyRocket"
local myRocket = RodisFireworksModule:GetRocketFactory();

-- Creates a new Rocket object with the given name and properties
local rocket1 = myRocket.new("Firework1", {
	YForce = 300; -- How fast the force is on the Y axis.
	TimeBeforeExplosion = 2.5; -- How long in seconds it should fly before exploding.
})

-- Ignite the rocket
rocket1:Ignite()

-- Wait for the rocket to complete then wait 5 seconds and respawn and ignite it.
rocket1.Completed:Connect(function()
    rocket1:Respawn()
    task.wait(5)
    rocket1:Ignite()
end)
```



