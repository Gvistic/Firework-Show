--// These are the default properties for Rocket.

local assets = require(script.Assets)

local particles = assets.Particles

local Flash1 = particles.Flash
local Flash2 = particles.Flash2
local Stars = particles.Stars
local Stars2 = particles.Stars2
local ExplodingLines = particles.ExplodingLines
local Smoke = particles.Smoke

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
	local ColorC = getRandomColor()
	return {
		Debug = false,
		UseCustomAttachment = false, -- If you set this to false, create an attachment named "FireworkAttachment" somewhere inside the firework.
		AttachmentAlwaysFacesUp = true,
		AttachmentCenterOfMass = true, --- Attachment will be placed center of mass. Force will also be applied at the center of mass.
		AutomaticlWeld = true,  -- If you use a model as a firework, this will weld everything together so that way the model does not fall apart when it's unanchored.
		EstimateForce = true, -- This will compute a new YForce depending on the given YForce and mass. Essentially making it such that no matter what YForce you set, the firework will always have enough force to go airborne. Essentially making YForce velocity.
		Mass = 2, -- If estimate force is true, this is the desired mass used in calculations
		YForce = math.random(2000, 3000), -- Velocity
		XForce = math.random(-20, 20) * 0.1,
		ZForce = math.random(-20, 20) * 0.1,
		TimeBeforeExplosion = math.random(20, 30) * 0.1,
		FireworkLifeTime = 10, -- Explosion duration before the firework and effects are destroyed. Setting this lower will remove the particle effects faster.
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
				Emit = 50; -- If the effects are particle emitters, this is the amount to emit.
				Pause = 0; --Delay/Wait (seconds) before the next sequence.
				Color =  ColorSequence.new{ColorSequenceKeypoint.new(0, ColorA), ColorSequenceKeypoint.new(1, ColorA)} -- You can also add any property that matches with the effects.
			},
			[2] = {
				Effects = {Flash2};
				Emit = 2;
				Pause = 0;
				Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ColorC), ColorSequenceKeypoint.new(1, ColorC)};
			},
			[3] = {
				Effects = {Stars};
				Emit = 500;
				Pause = 0;
				Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ColorB), ColorSequenceKeypoint.new(1, ColorB)};
			},
			[4] = {
				Effects = {Stars2};
				Emit = 500;
				Pause = 0;
				Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ColorC), ColorSequenceKeypoint.new(1, ColorC)};
			},
			[5] = {
				Effects = {ExplodingLines};
				Emit = 333;
				Pause = 0;
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, ColorA), ColorSequenceKeypoint.new(1, ColorA)};
			},
			[6] = {
				Effects = {Smoke};
				Emit = 50;
			},
			[7] = {
				Effects = {ExplosionSound1};
				EffectLifetime = 3; -- Duration of effect(s), time (seconds) before it gets destroyed.
				PlaybackSpeed = (math.random(80, 130)) * 0.01;
			},
			[8] = {
				Effects = {ExplosionSound2};
				EffectLifetime = 3;
				PlaybackSpeed = (math.random(40, 100)) * 0.01;
			},
			[9] = {
				Effects = {PointLight};
				EffectLifetime = 0.1;
			},
		}
	}
end

return defaultProperties
