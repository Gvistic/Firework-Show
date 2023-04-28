local FireworkAssetsUtility = require(script.Parent.Parent.Parent.Parent.Utility.FireworkAssets)

return {
    Particles = {
        Flash1 = FireworkAssetsUtility.CreateParticle({
            Name = "Flash1",
            Color = ColorSequence.new(Color3.new(1, 1, 1)),
            Brightness = 1,
            LightEmission = 5,
            LightInfluence = 0,
            Texture = "http://www.roblox.com/asset/?id=275750829",
            Size = NumberSequence.new(50),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(1, 1)
            }),
            Enabled = false,
            Lifetime = NumberRange.new(0.05, 0.1),
            Rate = 1000,
            Rotation = NumberRange.new(-360, 360),
            RotSpeed = NumberRange.new(-1000, 1000),
            Speed = NumberRange.new(0, 5000),
            SpreadAngle = Vector2.new(-360, 360),
            Shape = Enum.ParticleEmitterShape.Sphere,
            ShapePartial = 1,
            Acceleration = Vector3.new(0, 0, 0),
            Drag = 10000
        }),
        Flash2 = FireworkAssetsUtility.CreateParticle({
            Name = "Flash2",
            Color = ColorSequence.new(Color3.new(1, 1, 1)),
            Brightness = 1,
            LightEmission = 5,
            LightInfluence = 0,
            Texture = "http://www.roblox.com/asset/?id=275750829",
            Size = NumberSequence.new(2000),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.5),
                NumberSequenceKeypoint.new(1, 1)
            }),
            Enabled = false,
            Lifetime = NumberRange.new(0.05, 0.1),
            Rate = 1000,
            Rotation = NumberRange.new(-360, 360),
            RotSpeed = NumberRange.new(-1000, 1000),
            Speed = NumberRange.new(0, 5000),
            SpreadAngle = Vector2.new(-360, 360),
            Shape = Enum.ParticleEmitterShape.Sphere,
            ShapePartial = 1,
            Acceleration = Vector3.new(0, 0, 0),
            Drag = 10000
        }),
        Stars = FireworkAssetsUtility.CreateParticle({
            Name = "Stars",
            Color = ColorSequence.new(Color3.new(1, 1, 1)),
            Brightness = 5,
            LightEmission = 0,
            LightInfluence = 0,
            Texture = "http://www.roblox.com/asset/?id=5076152048",
            Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 5),
                NumberSequenceKeypoint.new(1, 0)
            }),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(1, 1)
            }),
            Enabled = false,
            Lifetime = NumberRange.new(1, 7),
            Rate = 2000,
            Rotation = NumberRange.new(-360, 360),
            RotSpeed = NumberRange.new(-1000, 1000),
            Speed = NumberRange.new(100, 2500),
            SpreadAngle = Vector2.new(-360, 360),
            Shape = Enum.ParticleEmitterShape.Sphere,
            ShapePartial = 1,
            Acceleration = Vector3.new(0, -250, 0),
            Drag = 20
        }),
        Stars2 = FireworkAssetsUtility.CreateParticle({
            Name = "Stars2",
            Color = ColorSequence.new(Color3.new(1, 1, 1)),
            Brightness = 5,
            LightEmission = 0,
            LightInfluence = 0,
            Texture = "http://www.roblox.com/asset/?id=5076152048",
            Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 10),
                NumberSequenceKeypoint.new(1, 0)
            }),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(1, 1)
            }),
            Enabled = false,
            Lifetime = NumberRange.new(1, 7),
            Rate = 2000,
            Rotation = NumberRange.new(-360, 360),
            RotSpeed = NumberRange.new(-1000, 1000),
            Speed = NumberRange.new(200, 6000),
            SpreadAngle = Vector2.new(-360, 360),
            Shape = Enum.ParticleEmitterShape.Sphere,
            ShapePartial = 1,
            Acceleration = Vector3.new(0, -250, 0),
            Drag = 20
        }),
        ExplodingLines = FireworkAssetsUtility.CreateParticle({
            Name = "ExplodingLines",
            Color = ColorSequence.new(Color3.new(1, 1, 1)),
            Brightness = 5,
            LightEmission = 0,
            LightInfluence = 0,
            Orientation = Enum.ParticleOrientation.VelocityParallel,
            Texture = "http://www.roblox.com/asset/?id=5076152048",
            Size = NumberSequence.new(10),
            Squash = NumberSequence.new(-5),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(1, 1)
            }),
            Enabled = false,
            Lifetime = NumberRange.new(0.5, 1),
            Rate = 1000,
            Rotation = NumberRange.new(0),
            RotSpeed = NumberRange.new(0),
            Speed = NumberRange.new(500),
            SpreadAngle = Vector2.new(-360, 360),
            Shape = Enum.ParticleEmitterShape.Sphere,
            ShapePartial = 1,
            Acceleration = Vector3.new(0, 0, 0),
            Drag = 0
        }),
        Smoke = FireworkAssetsUtility.CreateParticle({
            Name = "Smoke",
            Color = ColorSequence.new(Color3.new(1, 1, 1)),
            LightEmission = 0,
            LightInfluence = 1,
            Texture = "http://www.roblox.com/asset/?id=7648565918",
            Size = NumberSequence.new(100),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.2, 0.8),
                NumberSequenceKeypoint.new(1, 1),
            }),
            Enabled = false,
            Lifetime = NumberRange.new(5, 20),
            Rate = 100,
            Rotation = NumberRange.new(-360, 360),
            RotSpeed = NumberRange.new(-10, 10),
            Speed = NumberRange.new(500, 2500),
            SpreadAngle = Vector2.new(-360, 360),
            Shape = Enum.ParticleEmitterShape.Sphere,
            ShapePartial = 1,
            Acceleration = Vector3.new(0, 25, -100),
            Drag = 15
        }),
    },

    Lights = {
        PointLight = FireworkAssetsUtility.CreateLight({
            Name = "PointLight",
            Brightness = 10,
            Range = 60,
            Shadows = true,
            Enabled = false
        }, "PointLight"),
    },

    Sounds = {
        Launch = FireworkAssetsUtility.CreateSound({
            Name = "Launch",
            SoundId = "rbxassetid://947384308",
            RollOffMaxDistance = 500,
            RollOffMinDistance = 50,
            RollOffMode = Enum.RollOffMode.InverseTapered,
            PlaybackSpeed = 0.8,
            Volume = 1.5,
        }),
        Explosion = FireworkAssetsUtility.CreateSound({
            Name = "Explosion",
            RollOffMaxDistance = 25000,
            RollOffMinDistance = 1000,
            SoundId = "rbxassetid://269146157",
            RollOffMode = Enum.RollOffMode.InverseTapered,
            PlaybackSpeed = 1,
            Volume = 3,
        }),
        Explosion2 = FireworkAssetsUtility.CreateSound({
            Name = "Explosion2",
            RollOffMaxDistance = 100000,
            RollOffMinDistance = 10000,
            SoundId = "rbxassetid://269146157",
            RollOffMode = Enum.RollOffMode.InverseTapered,
            PlaybackSpeed = 1,
            Volume = 2,
        }),
        Crackle = FireworkAssetsUtility.CreateSound({
            Name = "Crackle",
            RollOffMaxDistance = 20000,
            RollOffMinDistance = 500,
            SoundId = "rbxassetid://269146157",
            RollOffMode = Enum.RollOffMode.InverseTapered,
            PlaybackSpeed = 0.8,
            Volume = 2,
        }),
    }
}
