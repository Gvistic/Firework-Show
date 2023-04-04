# 🎆 Rodis Fireworks
 
Welcome to the Rodis Firework Show Developer Event!
You can use this firework module to create your own amazing firework shows! 


 ## Installation
 1. Grab a copy from: [Here](https://www.roblox.com/library/12975366762/FireworkModule)
 2. Insert the model through the Roblox Studio toolbox
 3. From the model open "RodisFireworks" folder 
 4. Move and ungroup everything respectively:
     - "RodisFireworksModule" -> `ReplciatedStorage`
     - "RodisFireworkController" -> `ServerScriptService`
     - "RodisFireworks" -> `Workspace`

## Getting Started

To use the Rodis Firework module, follow these steps:

1. Create or import a rocket or firework launcher, and place them in Workspace, in the "RodisFireworks" folder.
2. Give each type of firework model a unique name (Though you can ignite multiple of the same fireworks if they have the same name).
3. Use the firework module to ignite the fireworks!

## Firework Module

The firework module has three functions:
1. `:Ignite(fireworkType, name, properties)`
    - This function ignites a rocket given the type, name, and optional properties.
        - **fireworkType**: The type of firework to ignite. This can be either "Rocket", "Crackle", "Confetti" or "Rainbow"
        - **name**: The name of the firework(s) you want to ignite.
        - **properties** (Optional): A table containing any additional properties for the rocket or firework.

2. `:IgniteClassic(fireworkType, name)`
    - This function fires the classical fireworks originally created by Stickmasterluke
        - **fireworkType**: The type of firework to ignite. This can be either "Fan", "Display", "Classic" or "Finale"
        - **name**: The name of the firework(s) you want to ignite.

3. `:GetRocketFactory()`
    - If you're a bit more familiar with object-oriented programming, this function returns the Rocket object,
so you have a bit more control features.

## Example (Non-Object):

1. Ignite firework with default properties:
```lua
-- Reference to firework module.
local RodisFireworksModule = require(game:GetService("ReplicatedStorage").RodisFireworksModule)

task.wait(2)

-- Ignite the firework named "Firework1" with type of "Rocket".
RodisFireworksModule:Ignite("Rocket","Firework1")
```

2. Ignite firework with custom properties:
```lua
local RodisFireworksModule = require(game:GetService("ReplicatedStorage").RodisFireworksModule)

task.wait(2)

-- Ignite the firework named "Firework1" with type of "Rocket" and custom properties.
RodisFireworksModule:Ignite("Rocket","Firework1", {
    YForce = 450; -- Velocity of the rocket in the Y-Axis.
    TimeBeforeExplosion = 3; -- Duration in seconds before it explodes. (Flight duration)
    -- You can view all other in the properties section
})

```


## Examples (Object):

1. Ignite firework and respawn it:
```lua
-- Reference to firework module.
local RodisFireworksModule = require(game:GetService("ReplicatedStorage").RodisFireworksModule)

-- Creates a new rocket factory named "MyRocket"
local myRocket = RodisFireworksModule:GetRocketFactory();

-- Creates a new Rocket object with the given name and properties
local rocket1 = myRocket.new("Firework1", {
	YForce = 300; -- How fast the force is on the Y axis.
	TimeBeforeExplosion = 2.5; -- How long in seconds it should fly before exploding.
    UseCustomAttachment = true; -- Be sure to name it "FireworkAttachment.
})

-- Ignite the rocket
rocket1:Ignite()

-- Wait for the rocket to complete its sequence of effects
rocket1.Completed:Wait()

-- Respawn the rocket
rocket1:Respawn()
```
2. Infinetly ignite and respawn firework:
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

3. Rocket Object and Custom properties:
```lua
local RodisFireworksModule = require(game:GetService("ReplicatedStorage").RodisFireworksModule)
local rocket = myRocket.new("Firework1")
rocket:SetDefaultProperties("Confetti")

rocket:Ignite({ -- For this ignite only, these properties will be applied.
	YForce = 400,
    XForce = 10,
    ZForce = math.random(5, 25),
	TimeBeforeExplosion = 5.5
});

rocket.Completed:Wait()
rocket:Respawn()

-- The rocket will still have the default properties for Confetti, but with YForce updated to 1000.
rocket:SetProperties({ 
    YForce = 1000;
})

rocket:Ignite() -- This ignite will have YForce of 1000.
```

## Properties:

These are the properties that you can set. You can also view the default properties for Rocket: [Here](https://github.com/Gvistic/Rodis-Fireworks/blob/main/src/shared/RodisFireworksModule/Modules/Fireworks/Rocket/Properties.lua)

| Property  | Type | Description | Example (Rocket Default) |
| :---: | :---: | ------------- | ------------- |
| AttachmentAlwaysFacesUp  | `boolean` | The attachment will face straight up to the sky, if you want to angle your fireworks at a different angle set this to false | `AttachmentAlwaysFacesUp = true;` |
| AttachmentCenterOfMass | `boolean` | The attachment and force will be applied to the fireworks center of mass. | `AttachmentCenterOfMass = true;` |
| AutomaticWeld | `boolean` | If the object firework is a model, it will weld all the parts together such that when the firework is unanchored it won't fall apart. | `AutomaticWeld = true;` |
| EstimateForce | `boolean` | This will compute a new YForce depending on the given YForce and mass. Essentially making it such that no matter what YForce you set, the firework will always have enough force to go airborne. | `EstimateForce = true;` |
| FireworkLifeTime | `number` | Duration of explosion before the firework and effects are destroyed. Setting this lower will remove the particle effects faster, i.e. 10 secconds will let the particles disapate themselves. Basically, after the explosion happens, how long should we wait before Debris service cleans/destroys the firework. | `FireworkLifeTime = 10;` |
| Mass | `number` | If estimate force is true, this is the desired mass used in calculations | `Mass = 2;` |
| TimeBeforeExplosion | `number` | The time in seconds before the firework explodes, basically for how long should it fly. | `TimeBeforeExplosion = math.random(20, 45) * 0.1;`
| UseCustomAttachment | `boolean` | If this is true, you can create your own attachment, be sure to name it "FireworkAttachment". Otherwise the module will create it's own attachment at the center of mass. | `UseCustomAttachment = false;` |
| XForce | `number` | The force applied to the Rocket in the X direction. | `XForce = math.random(-20, 20) * 0.1;` |
| YForce | `number` | The force applied to the Rocket in the Y direction. | `YForce = math.random(2000, 3000);` |
| ZForce | `number` | The force applied to the Rocket in the Y direction. | `ZForce = math.random(-20, 20) * 0.1;` |
| LaunchSequence | `table` | A table of sequences in which the module will execute for launch. | [View here](#LaunchSequence-Table) |
| ExplosionSequence | `table` | A table of sequences in which the module will execute for the explosion of the firework. | [View here](#ExplosionSequence-Table) |


## LaunchSequence Table
LaunchSequence table is a table that contains sequences (indexed tables) whose values will be executed when the firework is in flight before exploding. For example, you would want a launch sound and possible a particle trail to be played and enabled when the firework is launched.

Within each sequence you can include custom keys: [View here](#custom-keys-for-sequence-tables)

Within each sequence you can also add whichever property that your effects have. For example, if you have a sound in the effects table, you can include `PlaybackSpeed` or `Volume` etc.

Example: 
```lua
LaunchSequence = {
    [1] = {
        Effects = {LaunchSound, LaunchSound2};
        PlaybackSpeed = (math.random(40, 70)) * 0.01; 
        EffectLifetime = 3; 
        Pause = 0;
    },
    [2] = {
        Effects = {ParticleTrailEffect, TrailEffect2};
        EffectLifetime = 3;
        Pause = 3;
    },
}
```


## ExplosionSequence Table
ExplosionSequence table is a table that contains sequences (indexed tables) whoses values will be executed when the firework explodes. For example, you would want all your exploding firework particles to be emited, and explosion sounds

Within each sequence you can include custom keys: [View here](#custom-keys-for-sequence-tables)

Example: 
```lua
ExplosionSequence = {
    [1] = {
        Effects = {Flash1}; 
        Emit = 50;
        Pause = 0;
        Color =  ColorSequence.new{ColorSequenceKeypoint.new(0, ColorA), ColorSequenceKeypoint.new(1, ColorA)} 
    },
    [2] = {
        Effects = {Particles1};
        Emit = 500;
        Pause = 0;
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ColorB), ColorSequenceKeypoint.new(1, ColorB)};
    },
    [3] = {
        Effects = {ExplosionSound2};
        EffectLifetime = 3;
        PlaybackSpeed = (math.random(40, 100)) * 0.01;
    },
    [4] = {
        Effects = {PointLight};
        EffectLifetime = 0.1;
    },
}
```

## Custom Keys for Sequence Tables
| key | Type | Description | Example |
| :---: | :---: | ------------- | ------------- |
| `Effects` | table | Table of objects; i.e Particle Emitters, Sounds, Lights, Explosions, Sparkles etc. | `Effects = {particle1, particle2, sound1, sound2};` |
| `Emit` | number | If your effects contains any particle emitters, on execution of sequence, it will emit this amount. | `Emit = 1000;` |
| `Pause` | number |  Pause: Time in seconds to wait for the next sequence. | `Pause = 2` |
