# RodisFireworks
 
 Show off your amazing fireworks shows easily with this plugin! 


 ## Installation
 1. Grab a copy from: [TBA]
 2. Insert the model through Roblox Studio. 
 3. Open the "RodisFireworks" folder. 
 4. Move and ungroup everything respectively.
     - "RodisFireworksModule" -> `ReplciatedStorage`
     - "RodisFireworkController" -> `ServerScriptService`
     - "RodisFireworks" -> `Workspace`


## Example (Non-Object):

1. Ignite firework with default properties
```lua
-- Reference to firework module.
local RodisFireworksModule = require(game:GetService("ReplicatedStorage").RodisFireworksModule)

task.wait(2)

-- Ignite the firework named "Firework1" with type of "Rocket". (Other types: "Crackle", "Confetti" and "Rainbow")
RodisFireworksModule:Ignite("Rocket","Firework1")
```

2. Ignite firework with custom properties
```lua
local RodisFireworksModule = require(game:GetService("ReplicatedStorage").RodisFireworksModule)

task.wait(2)

-- Ignite the firework named "Firework1" with type of "Rocket" and custom properties.
RodisFireworksModule:Ignite("Rocket","Firework1", {
    YForce = 450; -- Velocity of the rocket in the Y-Axis.
    TimeBeforeExplosion = 3; -- Duration in seconds before it explodes. (Flight duration)
    UseCustomAttachment = true; -- Use a custom attachment on the firework, but be sure to name it "FireworkAttachment".
    -- You can view all other properties below: 
})

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

## Properties:

| Property  | Type | Example (Default Rocket) |
| :---: | ------------- | ------------- |
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
LaunchSequence table is a table that contains sequences that will be executed when the firework is in flight before exploding. For example, you would want a launch sound and possible a particle trail to be played and enabled.

These are the custom keys for the LaunchSequence table:
    - | `table` | Effects: Table of objects; You want bunch similar objects together.
    - | `number` | Emit: If you want to :Emit() a certain number of particles
    - | `number` | Pause: Time in seconds to wait for the next sequence.

Example: 
```lua
LaunchSequence = {
    [1] = {
        Effects = {LaunchSound, LaunchSound2}; -- Table of effects: Particle Emitters, Sounds, Lights, Explosions, Sparkles etc.
        PlaybackSpeed = (math.random(40, 70)) * 0.01; -- This a property of sound, you can add any properties that your effects have.
        EffectLifetime = 3; -- Duration of effect(s), time before it gets destroyed.
        Pause = 0; -- Time in seconds before the next sequence is executed.
    };

    [2] = {
        Effects = {ParticleTrailEffect, TrailEffect2};
        EffectLifetime = 3;
        Pause = 3;
    };
}
```


## ExplosionSequence Table
ExplosionSequence table is a table that contains sequences that will be executed when the firework explodes. For example, you would want all your exploding firework particles to be emited, and explosion sounds

The table has the same custom keys as the LaunchSequence.

Example: 
```lua
...
ExplosionSequence = {
    [1] = {
        Effects = {Flash1}; -- Table of effects: Particle Emitters, Sounds, Lights, Explosions, Sparkles etc.
        Emit = 50; -- If the effects are particle emmitters, this is the amount to emit.
        Pause = 0; --Delay/Wait before the next sequence.
        Color =  ColorSequence.new{ColorSequenceKeypoint.new(0, ColorA), ColorSequenceKeypoint.new(1, ColorA)} -- You can also add any property that matches with what you put in the effects.
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
