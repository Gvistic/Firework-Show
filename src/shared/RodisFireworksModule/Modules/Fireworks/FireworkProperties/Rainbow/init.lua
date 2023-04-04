local assets = require(script.Assets)

local particles = assets.Particles
local Flash1 = particles.Flash1
local Flash2 = particles.Flash2
local Smoke = particles.Smoke
local Rainbow = particles.Rainbow

local lights = assets.Lights
local PointLight = lights.PointLight

local sounds = assets.Sounds
local LaunchSound = sounds.Launch
local ExplosionSound1 = sounds.Explosion
local ExplosionSound2 = sounds.Explosion2


local function defaultProperties()
	local function getRandomColor()
		return Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
	end
	local ColorA = getRandomColor()
	local ColorB = getRandomColor()
	return {
		Debug = false,
		UseCustomAttachment = false, -- If you set this to false, be sure to create an atachment named "FireworkAttachment" somewhere inside the firework.
		AttachmentAlwaysFacesUp = true,
		AttachmentCenterOfMass = true, -- Attachment will be placed center of mass, sometimes if you angle a firework this will mess it up, try setting it to false.
		AutomaticlWeld = true, -- If you use a model as a firework, this will weld everything together so that way the model does not fall apart when it's unacnhored
		EstimateForce = true, -- This will compute a new YForce depending on the given YForce and mass. Essentially making it such that no matter what YForce you set, the firework will always have enough force to go airborne. Essentially making YForce velocity.
		Mass = 2, -- If estimate force is true, this is the desired mass used in calculations
		YForce = math.random(900, 2000), -- Velocity 
		XForce = math.random(-20, 20) * 0.1, 
		ZForce = math.random(-20, 20) * 0.1, 
		TimeBeforeExplosion = math.random(15, 23) * 0.1,
		FireworkLifeTime = 10, -- Duration of explosion before the firework and effects are destroyed. Setting this lower will remove the particle effects faster, i.e. 10 secconds will let the particles disapate themselves. 
		LaunchSequence = {
			[1] = {
				Effects = {LaunchSound};
				PlaybackSpeed = (math.random(40, 70)) * 0.01;
				EffectLifetime = 3; -- Duration of effect(s), time before it gets destroyed.
			}
		},
		ExplosionSequence = {
			[1] = {
				Effects = {Flash1}; -- Table of effects: Particle Emitters, Sounds, Lights, Explosions, Sparkles etc. 
				Emit = 50; -- If the effects are particle emmitters, this is the amount to emit.
				Pause = 0; --Delay/Wait before the next sequence.
				Color =  ColorSequence.new{ColorSequenceKeypoint.new(0, ColorA), ColorSequenceKeypoint.new(1, ColorA)}; -- You can also add any property that matches with what you put in the effects.
			},
			[2] = {
				Effects = {Flash2};
				Emit = 2;
				Pause = 0;
				Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ColorA), ColorSequenceKeypoint.new(1, ColorA)};
			},
			[3] = {
				Effects = {Smoke};
				Emit = 25;
			},
			[4] = {
				Effects = {ExplosionSound1};
				EffectLifetime = 3; -- Duration of effect(s), time before it gets destroyed.
				PlaybackSpeed = (math.random(80, 130)) * 0.01;
			},
			[5] = {
				Effects = {ExplosionSound2};
				EffectLifetime = 3;
				PlaybackSpeed = (math.random(40, 100)) * 0.01;
			},
			[6] = {
				Effects = {Rainbow};
				Emit = 2500;
			},
			[7] = {
				Effects = {PointLight};
				Color = ColorB;
				EffectLifetime = 0.1;
				Pause = 0.1;
			}
		}
	}
end

return defaultProperties
