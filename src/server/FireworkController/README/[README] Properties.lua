--[[
	The following is documentation for the properties table:
	If you want to see the table in aciton go to RodisFireworksModules > Modules > Fireworks > Rocket > Properties
	There are also a few others in "FireworkProperties" folder

	Properties
		The properties table can contain any of the following values:
			- boolean AttachmentAlwaysFacesUp:
				The attachment will face straight up to the sky, if you want to angle your fireworks at a different angle set this to false
				(Default: true)

			- boolean AttachmentCenterOfMass:
				The attachment and force will be applied to the fireworks center of mass.
				(Default: true)

			- boolean AutomaticWeld:
				If the object firework is a model, it will weld all the parts together such that when the firework is unanchored it won't fall apart.
				(Default: true)

			- boolean EstimateForce:
				This will compute a new YForce depending on the given YForce and mass. Essentially making it such that no matter what YForce you set,
				the firework will always have enough force to go airborne.
				(Default: true)

			- number FireworkLifeTime:
				Duration of explosion before the firework and effects are destroyed. Setting this lower will remove the particle effects faster,
				i.e. 10 secconds will let the particles disapate themselves. Basically, after the explosion happens, how long should we wait before
				Debris service cleans/destroys the firework.

			- number Mass:
				If estimate force is true, this is the desired mass used in calculations
				(Default: 2)

			- number TimeBeforeExplosion:
				The time in seconds before the firework explodes, basically for how long should it fly.
				(Default: math.random(20, 45) * 0.1)

			- boolean UseCustomAttachment:
				If this is true, you can create your own attachment, be sure to name it "FireworkAttachment".
				Otherwise the module will create it's own attachment at the center of mass.
				(Default: false)

			- number YForce:
				The force applied to the Rocket in the Y direction.
				(Default: math.random(2000, 3000))

			- number XForce:
				The force applied to the Rocket in the X direction.
				(Default: math.random(-20, 20) * 0.1)

			- number ZForce:
				The force applied to the Rocket in the Z direction.
				(Default: math.random(-20, 20) * 0.1)

			- table LaunchSequence:
				A table of sequences in which the module will execute for launch.
				This is what the table would look like:
					LaunchSequence = {
						[1] = {
							Effects = {LaunchSound, LaunchSound2};
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

				The table can contain as many sequences as you want, each sequence will be executed one after another. These are the custom keys:
					- table Effects: Table of objects, usually you would bunch different types of objects seperately.
					- number Emit: If you want to :Emit() a certain number of particles
					- number Pause: Time in seconds to wait for the next sequence.

			- table ExplosionSequence:
				A table of sequences in which the module will execute for the explosion of the firework.
				This is what the tabke would look like:
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

				The table can contain as many sequences as you want, each sequence will be executed one after another. These are the custom keys:
					- table Effects: Table of objects, usually you would bunch different types of objects seperately.
					- number Emit: If you want to :Emit() a certain number of particles
					- number Pause: Time in seconds to wait for the next sequence.
]]
